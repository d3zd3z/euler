(*
 * Problem 66
 *
 * 26 March 2004
 *
 * Consider quadratic Diophantine equations of the form:
 *
 * x^2 – Dy^2 = 1
 *
 * For example, when D=13, the minimal solution in x is 649^2 – 13x180^2 = 1.
 *
 * It can be assumed that there are no solutions in positive integers when D
 * is square.
 *
 * By finding minimal solutions in x for D = {2, 3, 5, 6, 7}, we obtain the
 * following:
 *
 * 3^2 – 2x2^2 = 1
 * 2^2 – 3x1^2 = 1
 * 9^2 – 5x4^2 = 1
 * 5^2 – 6x2^2 = 1
 * 8^2 – 7x3^2 = 1
 *
 * Hence, by considering minimal solutions in x for D ≤ 7, the largest x is
 * obtained when D=5.
 *
 * Find the value of D ≤ 1000 in minimal solutions of x for which the largest
 * value of x is obtained.
 *
 * 661
 *)

open Core
open Misc.Fix_zarith

type ilist = int list [@@deriving show]

(* This is known as Pell's equation, and the solutions are always a
 * term in the continued fraction expansion of square roots of
 * integers. *)
let expand s =
  match Pr064.sqrt_series s with
    | (x :: xs) ->
        Sequence.Infix.(
          Sequence.singleton x @
          Sequence.cycle_list_exn xs)
    | [] -> failwith "Do not call on perfect square"

let frac seq nth =
  match List.rev (Sequence.to_list (Sequence.take seq nth)) with
    | (x::xs) ->
        let rec loop result = function
          | [] -> result
          | (x::xs) ->
              loop Q.(of_int x + (one / result)) xs
        in
        loop (Q.of_int x) xs
    | [] -> failwith "Empty"

let is_dioph d q =
  let n = Q.num q in
  let m = Q.den q in
  let sol = Z.(n * n - of_int d * m * m) in
  (Z.(sol = one), n)

let first_x d =
  let series = expand d in
  let rec loop i =
    let q = frac series i in
    match is_dioph d q with
      | (true, x) -> x
      | _ -> loop (i + 1)
  in
  loop 1

let is_square d =
  let sqd = Misc.isqrt d in
  sqd * sqd = d

let solve () =
  let rec loop best_d best_x = function
    | d when d > 1000 -> best_d
    | d ->
        if is_square d then loop best_d best_x (d+1)
        else begin
          let x = first_x d in
          if Z.compare x best_x > 0 then
            loop d x (d+1)
          else
            loop best_d best_x (d+1)
        end
  in
  loop 0 Z.zero 1

let run () =
  printf "%d\n" (solve ())
