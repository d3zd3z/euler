(*
 * Much of this is in MathML and doesn't show up well in a comment.

 * The first ten continued fraction representations of (irrational) square
 * roots are:
 *
 * √2=[1;(2)], period=1
 * √3=[1;(1,2)], period=2
 * √5=[2;(4)], period=1
 * √6=[2;(2,4)], period=2
 * √7=[2;(1,1,1,4)], period=4
 * √8=[2;(1,4)], period=2
 * √10=[3;(6)], period=1
 * √11=[3;(3,6)], period=2
 * √12= [3;(2,6)], period=2
 * √13=[3;(1,1,1,1,6)], period=5
 *
 * Exactly four continued fractions, for N ≤ 13, have an odd period.
 *
 * How many continued fractions for N ≤ 10000 have an odd period?
 *
 * 1322
 *)

open Core

type triple = int * int * int [@@deriving eq]

let sqrt_series s =
  let a0 = Misc.isqrt s in
  let step m d a =
    let m = d*a - m in
    let d = (s - (m * m)) / d in
    (* This check is needed as d will be zero for exact squares.  The
     * value 'a' will not be used in this case. *)
    let a = if d = 0 then 0 else (a0 + m) / d in
    (m, d, a)
  in
  let (m1, d1, a1) as first = step 0 1 a0 in
  let rec steps m d a =
    if d = 0 then []
    else
      let (m, d, a) as this = step m d a in
      if equal_triple this first then [a]
      else a :: steps m d a
  in
  a0 :: steps m1 d1 a1

let is_even n = (n land 1) = 0

let solve () =
  List.init 10000 ~f:succ
  |> List.map ~f:sqrt_series
  |> List.filter ~f:(fun l -> is_even (List.length l))
  |> List.length

let run () =
  printf "%d\n" (solve ())
