(*
 * Problem 5
 *
 * 30 November 2001
 *
 *
 * 2520 is the smallest number that can be divided by each of the
 * numbers from 1 to 10 without any remainder.
 *
 * What is the smallest positive number that is evenly divisible by all
 * of the numbers from 1 to 20?
 *
 * 232792560
 *)

fun gcd (a, b) =
    if b = 0 then a
    else gcd (b, a mod b)

fun lcm (a, b) =
    (a div gcd (a, b)) * b

fun solve () = let
  fun add1 x = x + 1
  val nums = List.tabulate (20, add1)
in
  List.foldl lcm 1 nums
end

val () = print (Int.toString (solve ()) ^ "\n")
