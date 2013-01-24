(*
 * Problem 28
 *
 * 11 October 2002
 *
 *
 * Starting with the number 1 and moving to the right in a clockwise
 * direction a 5 by 5 spiral is formed as follows:
 *
 * 21 22 23 24 25
 * 20  7  8  9 10
 * 19  6  1  2 11
 * 18  5  4  3 12
 * 17 16 15 14 13
 *
 * It can be verified that the sum of the numbers on the diagonals is
 * 101.
 *
 * What is the sum of the numbers on the diagonals in a 1001 by 1001
 * spiral formed in the same way?
 *)

open Printf

let ring_sum n = 4*n*n - 6*n + 6

let euler28 () =
  let rec loop sum i =
    if i > 1001 then sum
    else loop (sum + ring_sum i) (i + 2) in
  (loop 0 3) + 1

let run () = printf "%d\n" (euler28 ())
