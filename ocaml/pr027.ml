(*
 * Problem 27
 *
 * 27 September 2002
 *
 *
 * Euler published the remarkable quadratic formula:
 *
 * n² + n + 41
 *
 * It turns out that the formula will produce 40 primes for the
 * consecutive values n = 0 to 39. However, when n = 40, 40^2 + 40 + 41
 * = 40(40 + 1) + 41 is divisible by 41, and certainly when n = 41, 41²
 * + 41 + 41 is clearly divisible by 41.
 *
 * Using computers, the incredible formula  n² − 79n + 1601 was
 * discovered, which produces 80 primes for the consecutive values n =
 * 0 to 79. The product of the coefficients, −79 and 1601, is −126479.
 *
 * Considering quadratics of the form:
 *
 *     n² + an + b, where |a| < 1000 and |b| < 1000
 *
 *     where |n| is the modulus/absolute value of n
 *     e.g. |11| = 11 and |−4| = 4
 *
 * Find the product of the coefficients, a and b, for the quadratic
 * expression that produces the maximum number of primes for
 * consecutive values of n, starting with n = 0.
 *
 * -59231
 *)

open Core

let prime_length sieve a b =
  let rec loop n =
    let num = n*n + a*n + b in
    if num >= 2 && Sieve.is_prime sieve num then loop(n+1)
    else n in
  loop 0

(* b can't be negative, since n=0 is just b, so that one must be
   prime. *)
(* Also, b must be prime, which would help slightly with
   performance. *)
let euler27 () =
  let sieve = Sieve.create () in
  let longest = ref 0 in
  let longest_val = ref (0, 0) in
  for a = -999 to 999 do
    for b = 2 to 999 do
      let len = prime_length sieve a b in
      if len > !longest then begin
	longest := len;
	longest_val := (a, b)
      end
    done
  done;
  match !longest_val with a, b -> a * b

let run () =
  printf "%d\n" (euler27 ())
