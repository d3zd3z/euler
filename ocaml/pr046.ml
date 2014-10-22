(*
 * Problem 46
 *
 * 20 June 2003
 *
 *
 * It was proposed by Christian Goldbach that every odd composite
 * number can be written as the sum of a prime and twice a square.
 *
 * 9 = 7 + 2×1^2
 * 15 = 7 + 2×2^2
 * 21 = 3 + 2×3^2
 * 25 = 7 + 2×3^2
 * 27 = 19 + 2×2^2
 * 33 = 31 + 2×1^2
 *
 * It turns out that the conjecture was false.
 *
 * What is the smallest odd composite that cannot be written as the sum
 * of a prime and twice a square?
 *
 * 5777
 *)

open! Core.Std

(* Determine if this number can be composed of a Goldbach number. *)
let goldbach sv n =
  let ps = Sieve.primes_upto sv n in
  let _, ps = uw (Sequence.next ps) in
  let rec loop ps =
    match Sequence.next ps with
      | Some (p, ps') ->
          begin
            let b = (n-p) / 2 in
            let bsub = Misc.isqrt b in
            if bsub*bsub = b then
              Some p
            else
              loop ps'
          end
      | None -> None
  in loop ps

let solve () =
  let sv = Sieve.create () in
  let rec loop n =
    if Sieve.is_prime sv n then
      loop (n+2)
    else
      match goldbach sv n with
        | Some _ -> loop (n+2)
        | None -> n
  in loop 9

let run () =
  Printf.printf "%d\n" (solve ())
