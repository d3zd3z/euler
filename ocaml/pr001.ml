(**********************************************************************
 * Problem 1
 *
 * 05 October 2001
 *
 * If we list all the natural numbers below 10 that are multiples of 3
 * or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
 *
 * Find the sum of all the multiples of 3 or 5 below 1000.
 *
 * 234168
 **********************************************************************)

(* open Printf *)

open! Core.Std

let mult n = n mod 5 = 0 || n mod 3 = 0

let range a b =
  let rec loop x accum =
    if x < a then accum
    else loop (x-1) (x::accum) in
  loop b []

let pr1 () =
  let nums = range 1 1000 in
  let fnums = List.filter ~f:mult nums in
  List.fold_left ~init:0 ~f:(+) fnums

let run () = printf "%d\n" (pr1 ())
