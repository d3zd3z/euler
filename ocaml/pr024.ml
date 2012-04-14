(*
 * Problem 24
 *
 * 16 August 2002
 *
 *
 * A permutation is an ordered arrangement of objects. For example,
 * 3124 is one possible permutation of the digits 1, 2, 3 and 4. If all
 * of the permutations are listed numerically or alphabetically, we
 * call it lexicographic order. The lexicographic permutations of 0, 1
 * and 2 are:
 *
 * 012   021   102   120   201   210
 *
 * What is the millionth lexicographic permutation of the digits 0, 1,
 * 2, 3, 4, 5, 6, 7, 8 and 9?
 *)

open Printf

let euler24 () =
  let rec loop text count =
    if count = 1_000_000 then text
    else loop (Euler.string_next_permutation text) (count+1) in
  loop (String.copy "0123456789") 1

let () = printf "%s\n" (euler24 ())