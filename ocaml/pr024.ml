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
 *
 * 2783915460
 *)

open Core

let euler24 () =
  let rec loop text count =
    if count = 1_000_000 then text
    else loop (Misc.bytes_next_permutation text) (count+1) in
  loop (Bytes.of_string "0123456789") 1

let run () = printf "%s\n" (Bytes.to_string (euler24 ()))
