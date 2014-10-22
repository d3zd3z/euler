(*
 * Problem 48
 *
 * 18 July 2003
 *
 *
 * The series, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.
 *
 * Find the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000
 * ^1000.
 *
 * 9110846700
 *)

open! Core.Std

(* This should probably use explicit Int64, since the intermediate
 * result doesn't fit in a 32-bit int.  However, this constant will
 * cause compilation to fail on a 32-bit platform, which should be ok. *)

let modulus = 10_000_000_000

(* Simple expt with a modulus. *)
let expt base power =
  let rec loop result i =
    if i = power then result else
      loop ((result * base) mod modulus) (i+1)
  in loop 1 0

let solve () =
  let rec loop total i =
    if i > 1000 then total else
      loop ((total + expt i i) mod modulus) (i+1)
  in loop 0 1

let run () =
  printf "%d\n" (solve ())
