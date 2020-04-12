(*
 * Problem 57
 *
 * 21 November 2003
 *
 *
 * It is possible to show that the square root of two can be expressed
 * as an infinite continued fraction.
 *
 * √ 2 = 1 + 1/(2 + 1/(2 + 1/(2 + ... ))) = 1.414213...
 *
 * By expanding this for the first four iterations, we get:
 *
 * 1 + 1/2 = 3/2 = 1.5
 * 1 + 1/(2 + 1/2) = 7/5 = 1.4
 * 1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 1.41666...
 * 1 + 1/(2 + 1/(2 + 1/(2 + 1/2))) = 41/29 = 1.41379...
 *
 * The next three expansions are 99/70, 239/169, and 577/408, but the
 * eighth expansion, 1393/985, is the first example where the number of
 * digits in the numerator exceeds the number of digits in the
 * denominator.
 *
 * In the first one-thousand expansions, how many fractions contain a
 * numerator with more digits than denominator?
 *
 * 153
 *)

open Core
open Num

let (//) = Num.(//)

let zero = num_of_int 0
let one = num_of_int 1
let two = num_of_int 2
let ten = num_of_int 10

(* Sigh, they didn't seem to provide these. *)
let numerator = function
  | Int _ as n -> n
  | Big_int _ as n -> n
  | Ratio r -> Big_int (Ratio.numerator_ratio r)

let denominator = function
  | Int _ -> one
  | Big_int _ -> one
  | Ratio r -> Big_int (Ratio.denominator_ratio r)

let digit_count n =
  let rec loop n result =
    if n <=/ zero then result
    else loop (quo_num n ten) (result + 1) in
  loop n 0

let solve () =
  let rec loop step count s =
    if step = 1000 then count
    else
      let s2 = one // (s +/ one) +/ one in
      let c2 = if digit_count (numerator s2) > digit_count (denominator s2)
        then count + 1 else count in
      loop (step + 1) c2 s2 in
  loop 1 0 (one +/ (one // two))

let run () =
  printf "%d\n" (solve ())
