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
 *
 * 872187
 *)

open! Core.Std

let is_palindrome ?(base=10) number =
  number = Misc.reverse_number ~base:base number

let euler36 () =
  Sequence.fold (Sequence.range ~stop:`exclusive 1 1_000_000) ~init:0 ~f:(fun sum number ->
    if is_palindrome ~base:10 number &&
      is_palindrome ~base:2 number
    then sum+number
    else sum)

let run () = printf "%d\n" (euler36 ())
