(**********************************************************************
 * Problem 16
 *
 * 03 May 2002
 *
 *
 * 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
 *
 * What is the sum of the digits of the number 2^1000?
 **********************************************************************)

open Printf
open Num

let euler16 () =
  let zero = num_of_int 0 in
  let ten = num_of_int 10 in
  let rec sum_digits n result =
    if n =/ zero then result
    else sum_digits (quo_num n ten) (result +/ (mod_num n ten)) in
  int_of_num (sum_digits (num_of_int 2 **/ num_of_int 1000) zero)

let run () = printf "%d\n" (euler16 ())
