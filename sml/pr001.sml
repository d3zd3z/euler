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
 **********************************************************************)

structure Pr001 =
struct

fun mult n =
  (n mod 5) = 0  orelse  (n mod 3) = 0;

fun range (a, b) = let
  fun loop (x, accum) =
    if x < a then accum
    else loop (x-1, x :: accum)
in
  loop (b, [])
end;

fun solve () = let
  val nums = range (1, 1000)
  val fnums = List.filter mult nums
in
  List.foldl (fn (a, b) => a + b) 0 fnums
end;

(* print (Int.toString (solve ()) ^ "\n"); *)

end
