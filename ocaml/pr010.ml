(**********************************************************************
 * Problem 10
 *
 * 08 February 2002
 *
 *
 * The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
 *
 * Find the sum of all the primes below two million.
 *
 *
 *
 **********************************************************************)

open! Batteries
open Printf

let pr10 () =
  let sieve = Sieve.create () in
  let rec loop p sum =
    if p >= 2000000 then sum else
      let open! Int64 in
      loop (Sieve.next_prime sieve p)
	(sum + of_int p) in
  loop 2 0L

let run () = printf "%Ld\n" (pr10 ())
