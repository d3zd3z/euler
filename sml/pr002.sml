(*
 * Problem 2
 *
 * 19 October 2001
 *
 *
 * Each new term in the Fibonacci sequence is generated by adding the
 * previous two terms. By starting with 1 and 2, the first 10 terms
 * will be:
 *
 * 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
 *
 * By considering the terms in the Fibonacci sequence whose values do
 * not exceed four million, find the sum of the even-valued terms.
 *)

structure Pr002 =
struct

fun solve () = let
  fun loop (a, b, result) =
      if a >= 4000000 then result
      else
	let
	  val next = result + (if (a mod 2) = 0 then a else 0)
	in
	  loop (b, (a + b), next)
	end
in
  loop (1, 1, 0)
end;

(* print (Int.toString (solve ()) ^ "\n"); *)
end
