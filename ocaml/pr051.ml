(*
 * Problem 51
 *
 * 29 August 2003
 *
 *
 * By replacing the 1^st digit of *3, it turns out that six of the nine
 * possible values: 13, 23, 43, 53, 73, and 83, are all prime.
 *
 * By replacing the 3^rd and 4^th digits of 56**3 with the same digit,
 * this 5-digit number is the first example having seven primes among
 * the ten generated numbers, yielding the family: 56003, 56113, 56333,
 * 56443, 56663, 56773, and 56993. Consequently 56003, being the first
 * member of this family, is the smallest prime with this property.
 *
 * Find the smallest prime which, by replacing part of the number (not
 * necessarily adjacent digits) with the same digit, is part of an
 * eight prime value family.
 *
 * 121313
 *)

(* First thing to reason is that the substitute digit must be
 * initially either 0, 1, or 2, otherwise there aren't enough digits
 * to choose from.
 *
 * Second, it won't help to have 2 or 4 digits replaced, since by
 * choosing 8, one of the results will always be divisible by 3 (in
 * [0:9 .* 2 .% 3, one can choose at most 7 of the numbers without
 * hitting all of the moduli).  The only one that gives us a
 * possibility of not hitting a multiple of 3 is a multiple of 3
 * digits.  We'll start by just doing groups of 3. *)

open! Core.Std

(* Explode a number into a list of digits. *)
let rec explode num =
  if num <= 0 then []
  else num mod 10 :: explode (num / 10)

(* Expand the given digit sequence into a resulting number. *)
let implode digits =
  let rec loop num pow = function
    | [] -> num
    | (a::ar) -> loop (num + a * pow) (pow * 10) ar in
  loop 0 1 digits

(* Find the indices in the list of the places where 'n' is an element
 * of the list. *)
let finds digits n =
  let rec loop pos = function
    | [] -> []
    | (a::ar) ->
        if a = n then pos :: loop (pos+1) ar
        else loop (pos+1) ar in
  loop 0 digits

let rec raw_combos accum thunk = function
  | [] -> thunk accum
  | (a::ar) -> begin
    raw_combos accum thunk ar;
    raw_combos (a::accum) thunk ar
  end;
  ()

module BitSet : sig
  type t
  val of_list : int list -> t
  val mem : int -> t -> bool
end = struct
  type t = int
  let of_list nums =
    List.fold ~f:(fun num pos -> num lor (1 lsl pos)) ~init:0 nums
  let mem pos set =
    (set land (1 lsl pos)) <> 0
end

let replace digits places target =
  let places = BitSet.of_list places in
  let rec loop pos = function
    | [] -> []
    | (a::ar) ->
        (if BitSet.mem pos places then target else a) :: loop (pos+1) ar in
  loop 0 digits

(* Return all of the combinations of length 'len' of the given list. *)
let combinations lst len =
  let result = ref [] in
  let act items =
    if List.length items = len then
      result := items :: !result in
  raw_combos [] act lst;
  !result

exception Result of int

let check sieve inumber =
  let number = explode inumber in
  for early = 0 to 2 do
    List.iter ~f:(fun places ->
      let count = ref 0 in
      for i = early to 9 do
        if Sieve.is_prime sieve (implode (replace number places i)) then
          count := !count + 1
      done;
      if !count >= 8 then
        raise (Result inumber)
    ) (combinations (finds number early) 3)
  done

let run () =
  let sieve = Sieve.create () in
  let primes = Sieve.primes_upto sieve 1_000_000 in
  try
    Sequence.iter primes ~f:(fun p -> check sieve p);
    failwith "No result found"
  with Result r -> printf "%d\n" r
