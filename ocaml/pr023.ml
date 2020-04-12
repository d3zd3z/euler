(*
 * Problem 23
 *
 * 02 August 2002
 *
 * A perfect number is a number for which the sum of its proper
 * divisors is exactly equal to the number. For example, the sum of the
 * proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means
 * that 28 is a perfect number.
 *
 * A number n is called deficient if the sum of its proper divisors is
 * less than n and it is called abundant if this sum exceeds n.
 *
 * As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the
 * smallest number that can be written as the sum of two abundant
 * numbers is 24. By mathematical analysis, it can be shown that all
 * integers greater than 28123 can be written as the sum of two
 * abundant numbers. However, this upper limit cannot be reduced any
 * further by analysis even though it is known that the greatest number
 * that cannot be expressed as the sum of two abundant numbers is less
 * than this limit.
 *
 * Find the sum of all the positive integers which cannot be written as
 * the sum of two abundant numbers.
 *
 * 4179871
 *)

open Core

(*
module S = Set.IntSet

let is_abundant num =
  let dsum = List.sum (Sieve.IntFactory.divisors num) - num in
  dsum > num

let make_abundants limit = Enum.filter is_abundant (1 -- limit)

(* TODO: This computes most twice.  Second iteration can start at rest
   of first. *)
let sums limit =
  let abundants = Array.of_enum (make_abundants limit) in
  let s = ref S.empty in
  Array.iter (fun outer ->
    Array.iter (fun inner -> s := S.add (outer + inner) !s) abundants)
    abundants;
  !s

let euler23 () =
  let good_pairs = sums 28123 in
  let all_nums = S.of_enum (1 -- 28123) in
  Enum.sum (S.enum (S.diff all_nums good_pairs))
*)

(* Since we're computing all of the divisors, do it incrementally,
   rather than by division, which should be significantly faster. *)
let make_divisors limit =
  let result = Array.create ~len:limit 1 in
  for base = 2 to limit-1 do
    let n = ref (base+base) in
    while !n < limit do
      result.(!n) <- result.(!n) + base;
      n := !n + base
    done
  done;
  result

let make_abundants limit =
  let divisors = make_divisors limit in
  let result = ref [] in
  Array.iteri ~f:(fun i dc -> if i > 0 && i < dc then result := i :: !result) divisors;
  !result

let sums limit =
  let abundants = Array.of_list (make_abundants limit) in
  let s = Array.create ~len:limit false in
  Array.iter abundants ~f:(fun outer ->
    Array.iter abundants ~f:(fun inner ->
      let t = outer + inner in
      if t < limit then s.(t) <- true));
  let sum = ref 0 in
  for i = 1 to limit-1 do
    if not s.(i) then sum := !sum + i
  done;
  !sum

let euler23 () = sums 28123

let run () = printf "%d\n" (euler23 ())
