(* Core based utilities. *)

open Core

module Fix_zarith = struct
  module Z = struct
    include Z
    let (=) = Z.equal
    let (<>) a b = not (a = b)
  end

  module Q = struct
    include Q
    let (=) = Q.equal
    let (<>) a b = not (a = b)
  end
end

exception Last_permutation

(* A general vector type. *)
module type VEC = sig
  type t
  type elt
  val length : t -> int
  val get : t -> int -> elt
  val set : t -> int -> elt -> unit
end

(* TODO: Can we leverage the comparison found in Core? *)
module type CMP = sig
  type t
  val compare : t -> t -> int
end

module type PERM = sig
  type t
  val next_permutation : t -> t
end

module Make_permuter (Vec : VEC) (Cmp : CMP with type t = Vec.elt) : PERM with type t = Vec.t = struct
  module Array = Vec
  type t = Vec.t

  let swap text a b =
    let tmp = text.(a) in
    text.(a) <- text.(b);
    text.(b) <- tmp

  let reverse_subvec text a b =
    let rec loop a b =
      if a < b then begin
        swap text a b;
        loop (a+1) (b-1)
      end in
    loop a b

  (* Modify the vector in place, to generate the next lexical
   * permutation.  Raises Not_found if given the last permutation.
   * TODO: Fix this to not raise. *)
  let next_permutation text =
    let len = Array.length text in
    let k = ref (-1) in
    for x = 0 to len-2 do
      if Cmp.compare text.(x) text.(x+1) < 0 then
        k := x
    done;
    if !k < 0 then raise Last_permutation;
    let l = ref (-1) in
    for x = !k+1 to len-1 do
      if Cmp.compare text.(!k) text.(x) < 0 then
        l := x
    done;
    swap text !k !l;
    reverse_subvec text (!k+1) (len-1);
    text
end

(* Bytes doesn't define elt, so make that so. *)
module Bytes = struct
  include Bytes
  type elt = char
end

module Bytes_permuter = Make_permuter (Bytes) (Char)

let bytes_next_permutation = Bytes_permuter.next_permutation

let expt base power =
  let rec loop result base power =
    if power = 0 then result else begin
      let result = if (power land 1) <> 0
	then result * base else result in
      let base = base * base in
      loop result base (power lsr 1)
    end in
  loop 1 base power

let reverse_number ?(base=10) number =
  let rec loop number result =
    if number = 0 then result
    else loop (number / base) (result * base + (number mod base)) in
  loop number 0

(* How many times can we divide by 10 and get zero. *)
let number_of_digits number =
  let rec loop count number =
    if number = 0 then count
    else loop (count+1) (number/10) in
  loop 0 number

module MillerRabin = struct
  open Num
  open Big_int

  let zero = num_of_int 0
  let one = num_of_int 1
  let two = num_of_int 2
  let three = num_of_int 3
  let five = num_of_int 5
  let seven = num_of_int 7

  let num_and a b = match a with
    | Int a -> (match b with
	| Int b -> Int (a land b)
	| Big_int b -> Big_int (and_big_int (big_int_of_int a) b)
	| Ratio _ -> failwith "and of ratio")
    | Big_int a -> (match b with
	| Int b -> Big_int (and_big_int a (big_int_of_int b))
	| Big_int b -> Big_int (and_big_int a b)
	| Ratio _ -> failwith "and of ratio")
    | Ratio _ -> failwith "and of ratio"

  let num_shift_right num count = match num with
    | Int a -> Int (a lsr count)
    | Big_int a -> Big_int (shift_right_big_int a count)
    | Ratio _ -> failwith "shift of ratio"

  (* This is a little trickier, since it can overflow.  For
     simplicitly, just always convert the result to a big_int.  TODO:
     keep the int value as an int if possible. *)
  let num_shift_left num count = match num with
    | Int a -> Big_int (shift_left_big_int (big_int_of_int a) count)
    | Big_int a -> Big_int (shift_left_big_int a count)
    | Ratio _ -> failwith "shift of ratio"

  (* Compute ((base ** power) mod modulus) but more efficiently. *)
  let exp_mod base power modulus =
    let rec loop result base power =
      if power =/ zero then result else begin
	let result = if (num_and power one) <>/ zero
	  then mod_num (result */ base) modulus
	  else result in
	let base = mod_num (base */ base) modulus in
	loop result base (num_shift_right power 1)
      end in
    loop one base power

  (* Given a number n, compute the largest 'd' such that 2^d * s = n. *)
  let compute_s_d n =
    let n = n -/ one in
    let rec loop bit index =
      if (num_and n bit) <>/ zero then (index, num_shift_right n index)
      (* else loop (num_shift_left bit 1) (index + 1) in *)
      else loop (num_shift_left bit 1) (index + 1) in
    loop one 0

  (* Generate a (not very good) random number between 0 and n-1 *)
  let random n =
    let n = big_int_of_num n in
    let base = ref (big_int_of_int 0) in
    while compare_big_int !base n < 0 do
      let next = big_int_of_int (Random.bits ()) in
      base := or_big_int (shift_left_big_int !base 30) next
    done;
    num_of_big_int (mod_big_int !base n)

  (* Compute one round of Miller-Rabin.  Returns true if this number
   * might be prime, or false if it is definitely not. *)
  let mr_round n s d =
    let n_minus_one = n -/ one in
    let a = (random (n -/ three)) +/ two in
    let x = ref (exp_mod a d n) in
    if !x =/ one || !x =/ n_minus_one then true
    else begin
      let rec loop s =
	if s = 0 then false
	else begin
	  x := mod_num (!x */ !x) n;
	  if !x =/ one then false
	  else if !x =/ n_minus_one then true
	  else loop (s-1)
	end in
      loop s
    end

  (* Miller-Rabin primality test.  If returns true, probability will
   * be (1/4)^k. *)
  let is_prime ?(k=20) n =
    let (s, d) = compute_s_d n in
    let rec loop k =
      if k = 0 then true
      else begin
	if mr_round n s d then loop (k-1)
	else false
      end in
    loop k

  let is_prime ?(k=20) n =
    if n =/ two then true
    else if n =/ three then true
    else if n =/ five then true
    else if n =/ seven then true
    else if mod_num n two =/ zero then false
    else if mod_num n three =/ zero then false
    else if mod_num n five =/ zero then false
    else if mod_num n two =/ zero then false
    else is_prime ~k:k n

  let is_prime_int ?(k=20) n = is_prime ~k:k (num_of_int n)
end

module IntegerMillerRabin = struct
  let exp_mod base power modulus =
    let rec loop result base power =
      if power = 0 then result else begin
        let result = if (power land 1) <> 0
          then (result * base) mod modulus
          else result in
        let base = (base * base) mod modulus in
        loop result base (power lsl 1)
      end in
    loop 1 base power

  (* Given a number n, compute the largest 'd' such that 2^d * s = n *)
  let compute_s_d n =
    let n = n - 1 in
    let rec loop bit index =
      if (n land bit) <> 0 then (index, n lsr index)
      else loop (bit lsl 1) (index + 1) in
    loop 1 0

  (* Generate a (not very good) random number between 0 and n-1 *)
  let random n = Random.int n

  (* Compute one round of Miller-Rabin.  Returns true if this number
   * might be prime, or false if it is definitly not. *)
  let mr_round n s d =
    let n_minus_one = n - 1 in
    let a = (random (n - 3)) + 2 in
    let x = ref (exp_mod a d n) in
    if !x = 1 || !x = (-1) then true
    else begin
      let rec loop s =
        if s = 0 then false
        else begin
          x := (!x * !x) mod n;
          if !x = 1 then false
          else if !x = n_minus_one then true
          else loop (s-1)
        end in
      loop s
    end

  (* Miller-Rabin primality test.  If returns true, probability will
   * be (1/4)^k. *)
  let is_prime ?(k=20) n =
    let (s, d) = compute_s_d n in
    let rec loop k =
      if k = 0 then true
      else begin
        if mr_round n s d then loop (k-1)
        else false
      end in
    loop k

  let is_prime ?(k=20) n =
    if n = 2 || n = 3 || n = 5 || n = 7 then true
    else if n mod 2 = 0 || n mod 3 = 0 || n mod 5 = 0 || n mod 7 = 0 then false
    else is_prime ~k n
end

let int_is_prime = IntegerMillerRabin.is_prime

(* Translation of imperative solution. *)
let isqrt num =
  let num = ref num in
  let bit = ref 1 in
  while !bit lsl 2 <= !num do
    bit := !bit lsl 2
  done;
  let result = ref 0 in
  while !bit <> 0 do
    let rb = !result + !bit in
    let rlsr1 = !result lsr 1 in
    if !num >= rb then begin
      num := !num - rb;
      result := rlsr1 + !bit
    end else
      result := rlsr1;
    bit := !bit lsr 2
  done;
  !result

module Result =
  struct
    type 'a t = 'a option ref
    let make () = ref None
    let save result num = match !result with
      | None -> result := Some num
      | Some _ -> failwith "More than one result"
    let get result = match !result with
      | None -> failwith "No result"
      | Some r -> r
  end
