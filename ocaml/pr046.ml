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

module Enum = BatEnum
module SV = Sieve.IntFactory

(* Determine if this number can be composed of a Goldbach number. *)
let goldbach n =
  let ps = SV.primes_upto n in
  Enum.junk ps;
  let rec loop () =
    match Enum.get ps with
      | Some p ->
          begin
            let b = (n-p) / 2 in
            let bsub = Misc.isqrt b in
            if bsub*bsub == b then
              Some p
            else
              loop ()
          end
      | None -> None
  in loop ()

let solve () =
  let rec loop n =
    if SV.is_prime n then
      loop (n+2)
    else
      match goldbach n with
        | Some _ -> loop (n+2)
        | None -> n
  in loop 9

let run () =
  (*
  BatPrintf.printf "stuff: %a\n" (BatOption.print BatInt.print)
    (goldbach 27);
  *)
  Printf.printf "%d\n" (solve ())
