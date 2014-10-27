(*
 * Problem 55
 *
 * 24 October 2003
 *
 *
 * If we take 47, reverse and add, 47 + 74 = 121, which is palindromic.
 *
 * Not all numbers produce palindromes so quickly. For example,
 *
 * 349 + 943 = 1292,
 * 1292 + 2921 = 4213
 * 4213 + 3124 = 7337
 *
 * That is, 349 took three iterations to arrive at a palindrome.
 *
 * Although no one has proved it yet, it is thought that some numbers,
 * like 196, never produce a palindrome. A number that never forms a
 * palindrome through the reverse and add process is called a Lychrel
 * number. Due to the theoretical nature of these numbers, and for the
 * purpose of this problem, we shall assume that a number is Lychrel
 * until proven otherwise. In addition you are given that for every
 * number below ten-thousand, it will either (i) become a palindrome in
 * less than fifty iterations, or, (ii) no one, with all the computing
 * power that exists, has managed so far to map it to a palindrome. In
 * fact, 10677 is the first number to be shown to require over fifty
 * iterations before producing a palindrome:
 * 4668731596684224866951378664 (53 iterations, 28-digits).
 *
 * Surprisingly, there are palindromic numbers that are themselves
 * Lychrel numbers; the first example is 4994.
 *
 * How many Lychrel numbers are there below ten-thousand?
 *
 * NOTE: Wording was modified slightly on 24 April 2007 to emphasise
 * the theoretical nature of Lychrel numbers.
 *
 * 249
 *)

open! Core.Std
open Num

let (//) = Num.(//)

let zero = num_of_int 0
let ten = num_of_int 10

let digit_reverse num =
  let rec loop num result =
    if num =/ zero then result
    else loop (quo_num num ten)
      (result */ ten +/ (mod_num num ten)) in
  loop num zero

(* Using the 50-iteration limit defined for the problem, return
 * whether the given number is a Lychrel number. *)
let is_lychrel num =
  let num = num_of_int num in

  let rec loop num count =
    if count = 51 then true
    else
      let rev = digit_reverse num in
      if num =/ rev then false
      else
        loop (num +/ rev) (count + 1) in
  loop (num +/ digit_reverse num) 1

let solve () =
  Sequence.count (Sequence.range 1 10_000) ~f:is_lychrel
  (*
  let count = ref 0 in
  for i = 1 to 9_999 do
    if is_lychrel i then begin
      incr count;
      printf "%d %d\n" !count i
    end
  done;
  !count
  *)

let run () =
  printf "%d\n" (solve ())
