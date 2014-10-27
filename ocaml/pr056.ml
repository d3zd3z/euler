(*
 * Problem 56
 *
 * 07 November 2003
 *
 *
 * A googol (10^100) is a massive number: one followed by one-hundred
 * zeros; 100^100 is almost unimaginably large: one followed by
 * two-hundred zeros. Despite their size, the sum of the digits in each
 * number is only 1.
 *
 * Considering natural numbers of the form, a^b, where a, b < 100, what
 * is the maximum digital sum?
 *
 * 972
 *)

open! Core.Std
open Num

let (//) = Num.(//)

let zero = num_of_int 0
let ten = num_of_int 10

let digit_sum n =
  let rec loop result n =
    if n =/ zero then result
    else loop (int_of_num (mod_num n ten) + result) (quo_num n ten) in
  loop 0 n

let solve () =
  let biggest = ref 0 in
  for a = 1 to 99 do
    let aa = num_of_int a in
    for b = 1 to 99 do
      let bb = num_of_int b in
      let tmp = digit_sum (aa **/ bb) in
      if tmp > !biggest then
        biggest := tmp
    done
  done;
  !biggest

let run () =
  printf "%d\n" (solve ())
