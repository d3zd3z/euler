(*
 * Problem 47
 *
 * 04 July 2003
 *
 *
 * The first two consecutive numbers to have two distinct prime factors
 * are:
 *
 * 14 = 2 × 7
 * 15 = 3 × 5
 *
 * The first three consecutive numbers to have three distinct prime
 * factors are:
 *
 * 644 = 2² × 7 × 23
 * 645 = 3 × 5 × 43
 * 646 = 2 × 17 × 19.
 *
 * Find the first four consecutive integers to have four distinct
 * primes factors. What is the first of these numbers?
 *
 * 134043
 *)

open Core

let expect = 4

let solve () =
  let sieve = Sieve.create () in
  let rec loop i count =
    (* let facts = SV.factorize i in *)
    let facts = Sieve.factorize sieve i in
    if List.length facts = expect then begin
      let c2 = count + 1 in
      if c2 = expect then
        (i-expect+1)
      else
        loop (i+1) c2
    end else
      loop (i+1) 0
  in loop 2 0

let run () =
  printf "%d\n" (solve ())
