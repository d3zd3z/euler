(*
 * Problem 26
 *
 * 13 September 2002
 *
 *
 * A unit fraction contains 1 in the numerator. The decimal
 * representation of the unit fractions with denominators 2 to 10 are
 * given:
 *
 *     ^1/[2]  =  0.5
 *     ^1/[3]  =  0.(3)
 *     ^1/[4]  =  0.25
 *     ^1/[5]  =  0.2
 *     ^1/[6]  =  0.1(6)
 *     ^1/[7]  =  0.(142857)
 *     ^1/[8]  =  0.125
 *     ^1/[9]  =  0.(1)
 *     ^1/[10] =  0.1
 *
 * Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle.
 * It can be seen that ^1/[7] has a 6-digit recurring cycle.
 *
 * Find the value of d < 1000 for which ^1/[d] contains the longest
 * recurring cycle in its decimal fraction part.
 *
 * 983
 *)

open! Core.Std

(*
let one = num_of_int 1
let ten = num_of_int 10

(* It is only necessary to search the primes, since a composite would
   have at most the repeat of it's longest repeating factor. *)

(* TODO: This could be done with modulus exponentiation. *)

(* The key is to solve "10^k = 1 (mod n)" It is important to never
   call this for n=2 or 5, since if the remainder is zero, it will never
   terminate. *)
let dlog n =
  let n = num_of_int n in
  let rec loop k =
    if mod_num (ten **/ num_of_int k) n =/ one then k
    else loop (k+1) in
  loop 1
*)

(* Compute  base^power mod modulus efficiently. *)
let exp_mod base power modulus =
  let rec loop result base power =
    if power = 0 then result else begin
      let result = if (power land 1) <> 0
	then (result * base) mod modulus
	else result in
      let base = (base * base) mod modulus in
      loop result base (power lsr 1)
    end in
  loop 1 base power

let dlog n =
  let rec loop k =
    if exp_mod 10 k n = 1 then k
    else loop (k+1) in
  loop 1

module IS = Sieve.IntSieve

let primes_from_7 () =
  let s = IS.initial in
  let _, s = IS.next s in
  let _, s = IS.next s in
  let _, s = IS.next s in
  s

let euler26 () =
  let rec loop s largest largest_p =
    let p, s = IS.next s in
    if p > 1000 then largest_p else begin
      let digits = dlog p in
      if digits > largest then
	loop s digits p
      else
	loop s largest largest_p
    end in
  loop (primes_from_7 ()) 0 0

(* Easier solution, using Sequence. *)
let int_primes () =
  let p = IS.to_sequence (IS.initial) in
  let p = Sequence.drop_while p ~f:(fun x -> x < 7) in
  Sequence.take_while p ~f:(fun x -> x < 1000)

let euler26b () =
  let each (largest, largest_p) p =
    let digits = dlog p in
    if digits > largest then (digits, p)
    else (largest, largest_p) in
  let _, result = Sequence.fold ~init:(0, 0) ~f:each (int_primes ()) in
  result

let run () = printf "%d\n%!" (euler26b ())
(*
let () = Bench.bench (ignore euler26)
let () = Bench.bench (ignore euler26b)
*)
