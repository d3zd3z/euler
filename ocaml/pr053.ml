(*
 * Problem 53
 *
 * 26 September 2003
 *
 *
 * There are exactly ten ways of selecting three from five, 12345:
 *
 * 123, 124, 125, 134, 135, 145, 234, 235, 245, and 345
 *
 * In combinatorics, we use the notation, ^5C[3] = 10.
 *
 * In general,
 *
 * ^nC[r] = n!       ,where r ≤ n, n! = n×(n−1)×...×3×2×1, and 0! = 1.
 *          r!(n−r)!
 *
 * It is not until n = 23, that a value exceeds one-million: ^23C[10] =
 * 1144066.
 *
 * How many, not necessarily distinct, values of  ^nC[r], for 1 ≤ n ≤
 * 100, are greater than one-million?
 *
 * 4075
 *)

open Core

(* The answer is just Pascal's triangle.  To make this easier to
 * implement, build it from a saturating arithmetic type. *)
module Saturating = struct
  type t = Num of int | Saturated
  let zero = Num 0
  let one = Num 1

  let limit = 1_000_000

  let add a b = match (a, b) with
    | (Num a, Num b) ->
        let sum = a + b in
        if sum < limit then
          Num sum
        else
          Saturated
    | (Saturated, _) -> Saturated
    | (_, Saturated) -> Saturated

  let is_saturated = function
    | Saturated -> true
    | Num _ -> false
end

module S = Saturating

let count f lst =
  let rec loop total = function
    | [] -> total
    | (a::ar) -> loop (if f a then total+1 else total) ar in
  loop 0 lst

let array_count f ary =
  let total = ref 0 in
  for i = 0 to Array.length ary - 1 do
    if f ary.(i) then
      total := !total + 1
  done;
  !total

let solve () =
  let buffer = Array.create ~len:101 S.zero in
  buffer.(0) <- S.one;
  let counter = ref 0 in
  for i = 1 to 100 do
    for j = i downto 1 do
      buffer.(j) <- S.add buffer.(j) buffer.(j-1)
    done;
    counter := !counter + array_count S.is_saturated buffer
  done;
  !counter

let run () =
  printf "%d\n" (solve ())
