(*
 * Problem 36
 *
 * 31 January 2003
 *
 *
 * The decimal number, 585 = 1001001001[2] (binary), is palindromic in
 * both bases.
 *
 * Find the sum of all numbers, less than one million, which are
 * palindromic in base 10 and base 2.
 *
 * (Please note that the palindromic number, in either base, may not
 * include leading zeros.)
 *)

open Batteries
open Printf

let is_palindrome ?(base=10) number =
  number = Misc.reverse_number ~base:base number

let euler36 () =
  Enum.fold (fun sum number ->
    if is_palindrome ~base:10 number &&
      is_palindrome ~base:2 number
    then sum+number
    else sum) 0 (1 --^ 1_000_000)

let run () = printf "%d\n" (euler36 ())
