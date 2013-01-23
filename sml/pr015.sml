(*
 * Problem 15
 *
 * 19 April 2002
 *
 *
 * Starting in the top left corner of a 2x2 grid, there are 6 routes
 * (without backtracking) to the bottom right corner.
 *
 * [p_015]
 *
 * How many routes are there through a 20x20 grid?
 *
 * 137846528820
 *)

structure Pr015 =
struct

fun constantly x _ = x

fun base n = List.tabulate (n+1, constantly (1 : IntInf.int))

fun bump (a::b::r) : IntInf.int list = a :: bump (a+b :: r)
  | bump a = a

fun solve' n =
    List.last (foldl (fn (a, b) => a b) (base n) (List.tabulate (n, constantly bump)))

fun solve () = solve' 20

(* val () = print (IntInf.toString (euler ()) ^ "\n") *)
end
