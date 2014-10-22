(*
 * Problem 52
 *
 * 12 September 2003
 *
 *
 * It can be seen that the number, 125874, and its double, 251748,
 * contain exactly the same digits, but in a different order.
 *
 * Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and
 * 6x, contain the same digits.
 *
 * 142857
 *)

(* This is a well known property of the expansion of 1/7.  But it is
 * interesting to solve by searching, anyway.
 *
 * Use the same trick as problem 49 to computer a 'number' value
 * describing the bag of digits present.
 *)

open! Core.Std

let early_primes =
  let buf = Array.create ~len:10 0 in
  let sieve = Sieve.create () in
  let rec loop p i =
    if i < 10 then begin
      buf.(i) <- p;
      loop (Sieve.next_prime sieve p) (i+1)
    end else
      buf
  in loop 2 0

(* Generate a unique identifier for a given (small) number that
 * doesn't account for the position of the digits, just which digits
 * and how many of each, using the first 10 primes for the digits 0-9.
 *)
let number_value num =
  let rec loop num total =
    if num > 0 then
      loop (num / 10) (total * early_primes.(num mod 10))
    else
      total
  in loop num 1

module Result = Misc.Result

let solve () =
  let seq = [2;3;4;5;6] in
  let result = Result.make () in
  for base = 100000 to 199999 do
    let bval = number_value base in
    if List.for_all seq ~f:(fun m -> number_value (base * m) = bval) then
      Result.save result base
  done;
  Result.get result

let run () =
  printf "%d\n" (solve ())
