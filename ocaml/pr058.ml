(*
 * Problem 58
 *
 * 05 December 2003
 *
 *
 * Starting with 1 and spiralling anticlockwise in the following way, a
 * square spiral with side length 7 is formed.
 *
 * 37 36 35 34 33 32 31
 * 38 17 16 15 14 13 30
 * 39 18  5  4  3 12 29
 * 40 19  6  1  2 11 28
 * 41 20  7  8  9 10 27
 * 42 21 22 23 24 25 26
 * 43 44 45 46 47 48 49
 *
 * It is interesting to note that the odd squares lie along the bottom
 * right diagonal, but what is more interesting is that 8 out of the 13
 * numbers lying along both diagonals are prime; that is, a ratio of 8/
 * 13 ≈ 62%.
 *
 * If one complete new layer is wrapped around the spiral above, a
 * square spiral with side length 9 will be formed. If this process is
 * continued, what is the side length of the square spiral for which
 * the ratio of primes along both diagonals first falls below 10%?
 *
 * 26241
 *)

open Core

let solve () =
  (* let sieve = Sieve.create () in *)

  (* Imperative is a little easier to write at this point. *)
  let primes = ref 0 in
  let non_primes = ref 1 in
  let size = ref 1 in
  let span = ref 0 in

  let rec loop () =
    (* printf "primes:%d, non_primes:%d, span:%d\n%!" !primes !non_primes !span; *)
    span := !span + 2;
    for _ = 1 to 4 do
      size := !size + !span;
      incr (if Misc.MillerRabin.is_prime_int !size then primes else non_primes);
    done;
    if !primes * 10 >= !primes + !non_primes then
      loop ()
    else !span + 1 in
  loop ()

(* Write this out without using explicit mutation.  There's enough
 * state being passed around, let's put it in its own type. *)
type state = {
  primes : int;
  non_primes : int;
  size : int }

let next_state state span =
  let f ({ primes; non_primes; size } as state) =
    let size = size + span in
    if Misc.MillerRabin.is_prime_int size then
      { state with primes = primes + 1; size = size }
    else
      { state with non_primes = non_primes + 1; size = size } in
  f (f (f (f state)))

let solve2 () =
  let rec loop span state =
    (* printf "primes:%d, non_primes:%d, span:%d\n%!" state.primes state.non_primes span; *)
    let state = next_state state span in
    if state.primes * 10 >= state.primes + state.non_primes then
      loop (span + 2) state
    else
      span + 1 in
  loop 2 { primes = 0; non_primes = 0; size = 1 }

let run () =
  printf "%d\n" (solve ())
  (*
   * TODO: solve2 generates the wrong answer.
  printf "%d\n" (solve2 ())
  *)
