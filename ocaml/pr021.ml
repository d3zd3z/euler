(*
 * Problem 21
 *
 * 05 July 2002
 *
 * Let d(n) be defined as the sum of proper divisors of n (numbers less
 * than n which divide evenly into n).
 * If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable
 * pair and each of a and b are called amicable numbers.
 *
 * For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20,
 * 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of
 * 284 are 1, 2, 4, 71 and 142; so d(284) = 220.
 *
 * Evaluate the sum of all the amicable numbers under 10000.
 *)

open! Batteries
open Printf

let is_amicable sieve num =
  let other = Sieve.proper_divisor_sum sieve num in
  other <> num && (Sieve.proper_divisor_sum sieve other = num)

let euler21 () =
  let sieve = Sieve.create () in
  let total = ref 0 in
  for i = 2 to 9999 do
    if is_amicable sieve i then
      total := !total + i
  done;
  !total

let run () = printf "%d\n" (euler21 ())
