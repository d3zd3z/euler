(*
 * Problem 20
 *
 * 21 June 2002
 *
 * n! means n × (n − 1) × ... × 3 × 2 × 1
 *
 * For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
 * and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0
 * + 0 = 27.
 *
 * Find the sum of the digits in the number 100!
 *)

open Printf
open Num

let fact n =
  let rec loop result = function
    | 0 -> result
    | n -> loop (result */ num_of_int n) (n-1) in
  loop (num_of_int 1) n

let ten = num_of_int 10
let zero = num_of_int 0
let sum_digits n =
  let rec loop result n =
    if n =/ zero then result
    else loop (result + (int_of_num (mod_num n ten))) (quo_num n ten) in
  loop 0 n

let () = printf "%d\n" (sum_digits (fact 100))
