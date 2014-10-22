(*
 * Problem 38
 *
 * 28 February 2003
 *
 *
 * Take the number 192 and multiply it by each of 1, 2, and 3:
 *
 *     192 × 1 = 192
 *     192 × 2 = 384
 *     192 × 3 = 576
 *
 * By concatenating each product we get the 1 to 9 pandigital,
 * 192384576. We will call 192384576 the concatenated product of 192
 * and (1,2,3)
 *
 * The same can be achieved by starting with 9 and multiplying by 1, 2,
 * 3, 4, and 5, giving the pandigital, 918273645, which is the
 * concatenated product of 9 and (1,2,3,4,5).
 *
 * What is the largest 1 to 9 pandigital 9-digit number that can be
 * formed as the concatenated product of an integer with (1,2, ... , n)
 * where n > 1?
 *
 * 932718654
 *)

open! Core.Std

(* Is this number a full 9-element pandigital number. *)
let is_pandigital number =
  let rec loop bits number =
    if number = 0 then bits = 1022 (* 1-9 without the zero. *)
    else begin
      let n = number / 10 in
      let m = number mod 10 in
      let bit = 1 lsl m in
      if (bits land bit) = 0 then
	loop (bits lor bit) n
      else false
    end in
  loop 0 number

(* Given a numeric base, return a resulting number by successively
   multiplying by the integers starting with 1. *)
let large_sum base =
  let rec loop digits result i =
    if digits >= 9 then result
    else begin
      let piece = base * i in
      let piece_digits = Misc.number_of_digits piece in
      loop (digits + piece_digits)
	(result * Misc.expt 10 piece_digits + piece)
	(i + 1)
    end in
  loop 0 0 1

let euler38 () =
  Sequence.fold (Sequence.range ~stop:`exclusive 1 10000)
    ~init:0
    ~f:(fun largest a ->
      let sum = large_sum a in
      if is_pandigital sum then max largest sum
      else largest)

let run () = printf "%d\n" (euler38 ())
