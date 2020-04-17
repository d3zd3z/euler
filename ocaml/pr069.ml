(*
 * Problem 69
 *
 * 07 May 2004
 *
 *
 * Euler's Totient function, φ(n) [sometimes called the phi function], is used to
 * determine the number of numbers less than n which are relatively prime to n.
 * For example, as 1, 2, 4, 5, 7, and 8, are all less than nine and relatively
 * prime to nine, φ(9)=6.
 *
 * ┌──┬────────────────┬────┬─────────┐
 * │n │Relatively Prime│φ(n)│n/φ(n)   │
 * ├──┼────────────────┼────┼─────────┤
 * │2 │1               │1   │2        │
 * ├──┼────────────────┼────┼─────────┤
 * │3 │1,2             │2   │1.5      │
 * ├──┼────────────────┼────┼─────────┤
 * │4 │1,3             │2   │2        │
 * ├──┼────────────────┼────┼─────────┤
 * │5 │1,2,3,4         │4   │1.25     │
 * ├──┼────────────────┼────┼─────────┤
 * │6 │1,5             │2   │3        │
 * ├──┼────────────────┼────┼─────────┤
 * │7 │1,2,3,4,5,6     │6   │1.1666...│
 * ├──┼────────────────┼────┼─────────┤
 * │8 │1,3,5,7         │4   │2        │
 * ├──┼────────────────┼────┼─────────┤
 * │9 │1,2,4,5,7,8     │6   │1.5      │
 * ├──┼────────────────┼────┼─────────┤
 * │10│1,3,7,9         │4   │2.5      │
 * └──┴────────────────┴────┴─────────┘
 *
 * It can be seen that n=6 produces a maximum n/φ(n) for n ≤ 10.
 *
 * Find the value of n ≤ 1,000,000 for which n/φ(n) is a maximum.
 *
 * 510510
 *)

open Core

(* The totient is related to the prime factors of the number.  Having
 * powers greater than 1 of primes will make the ratio smaller, so the
 * best values are when each prime has a power of 1.  The best answer
 * to the puzzle is simply to find the largest product of initial
 * prime numbers that fits within the problem range.
 *
 * This can actually be solved fairly easily on paper, as the result
 * is just the product of the first 7 primes. *)
let solve () =
  let sv = Sieve.create () in
  let rec loop total p =
    let p' = Sieve.next_prime sv p in
    let total' = total * p' in
    if total' > 1000000 then total
    else loop total' p'
  in
  loop 2 2

let run () =
  printf "%d\n" (solve ())
