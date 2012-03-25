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

open Sieve
open Printf

let pr10 () =
  let rec loop s sum =
    let (p, s') = Int64Sieve.next s in
    if p >= 2000000L then sum else
      loop s' (Int64.add sum p)
  in loop Int64Sieve.initial 0L

(* On 64 bit platforms, regular integers are large enough. *)
let pr10b () =
  let rec loop s sum =
    let (p, s') = IntSieve.next s in
    if p >= 2000000 then sum else
      loop s' (sum + p)
  in loop IntSieve.initial 0

let _ = printf "%Ld\n" (pr10 ())
(* let _ = printf "%d\n" (pr10b ()) *)
