(*
 * Problem 6
 *
 * 14 December 2001
 *
 *
 * The sum of the squares of the first ten natural numbers is,
 *
 * 1^2 + 2^2 + ... + 10^2 = 385
 *
 * The square of the sum of the first ten natural numbers is,
 *
 * (1 + 2 + ... + 10)^2 = 55^2 = 3025
 *
 * Hence the difference between the sum of the squares of the first ten
 * natural numbers and the square of the sum is 3025 − 385 = 2640.
 *
 * Find the difference between the sum of the squares of the first one
 * hundred natural numbers and the square of the sum.
 *
 * 25164150
 *)

structure Pr006 =
struct

fun solve' count = let
  val nums = List.tabulate (count, fn x => x + 1)
  val sumsq = List.foldl (op +) 0 nums
  val sumsq = sumsq * sumsq
  val sq = List.map (fn x => x * x) nums
  val sq = List.foldl (op +) 0 sq
in
  sumsq - sq
end

fun solve () = solve' 100

(* val () = print (Int.toString (solve 100) ^ "\n") *)
end
