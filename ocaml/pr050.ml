(*
 * Problem 50
 *
 * 15 August 2003
 *
 *
 * The prime 41, can be written as the sum of six consecutive primes:
 *
 * 41 = 2 + 3 + 5 + 7 + 11 + 13
 *
 * This is the longest sum of consecutive primes that adds to a prime
 * below one-hundred.
 *
 * The longest sum of consecutive primes below one-thousand that adds
 * to a prime, contains 21 terms, and is equal to 953.
 *
 * Which prime, below one-million, can be written as the sum of the
 * most consecutive primes?
 *
 * 997651
 *)

open! Core.Std

let primes_to n =
  let sieve = Sieve.create () in
  let rec loop p accum =
    if p > n then List.rev accum
    else
      loop (Sieve.next_prime sieve p) (p::accum)
  in loop 2 []

(* Left fold of inits.  Like fold_left, but the function takes a list of items
 * of the successive inits of the original. *)
(* val left_inits : ('a -> 'b list -> 'a) -> 'a -> 'b list -> 'a *)
let rec left_inits f a0 = function
  | [] -> a0
  | (_::br) as ba -> left_inits f (f a0 ba) br

let solve () =
  let limit = 1_000_000 in
  let sieve = Sieve.create () in

  (* This collects together all of the runs of primes from the initial part of
   * this list. *)
  let rec primesum res count asum = function
    | [] -> res
    | (a::_) when asum+a >= limit -> res
    | (a::ar) ->
        let a2 = asum + a in
        let next = if Sieve.is_prime sieve a2 then
          (count + 1, a2) :: res
        else
          res in
        primesum next (count+1) a2 ar
  in
  let best_prime sofar primes =
    let pieces = primesum [] 0 0 primes in
    List.fold pieces ~f:max ~init:sofar in

  let primes = primes_to limit in
  let (_, best) = left_inits best_prime (0,0) primes in
  best

let run () =
  printf "%d\n" @@ solve ()
