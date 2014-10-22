(*
 * Problem 35
 *
 * 17 January 2003
 *
 * The number, 197, is called a circular prime because all rotations of
 * the digits: 197, 971, and 719, are themselves prime.
 *
 * There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17,
 * 31, 37, 71, 73, 79, and 97.
 *
 * How many circular primes are there below one million?
 *
 * 55
 *)

open! Core.Std

let number_of_digits num =
  let rec loop count num =
    if num = 0 then count
    else loop (count+1) (num/10) in
  loop 0 num

let number_rotations num =
  let len = number_of_digits num in
  let highest_one = Misc.expt 10 (len-1) in
  let rec loop right left accum n result =
    if left > highest_one then result else begin
      let n_quotient = n / 10 in
      let n_remainder = n mod 10 in
      let new_accum = accum + left * n_remainder in
      let next = n_quotient + right * new_accum in
      loop (right/10) (left*10) new_accum n_quotient (next :: result)
    end in
  loop highest_one 1 0 num []

(* Return a sequence of primes up to the given limit. *)
let primes_upto sieve limit =
  let next p =
    if p > limit then None
    else Some (p, Sieve.next_prime sieve p) in
  Sequence.unfold ~init:2 ~f:next

let euler35 () =
  let sieve = Sieve.create () in
  let each count prime =
    if List.for_all ~f:(Sieve.is_prime sieve) (number_rotations prime)
    then count + 1 else count in
  Sequence.fold (primes_upto sieve 1_000_000)
    ~init:0 ~f:each

let run () = printf "%d\n" (euler35 ())
