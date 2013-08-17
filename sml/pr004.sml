(*
 * Problem 4
 *
 * 16 November 2001
 *
 *
 * A palindromic number reads the same both ways. The largest
 * palindrome made from the product of two 2-digit numbers is 9009 = 91
 * x 99.
 *
 * Find the largest palindrome made from the product of two 3-digit
 * numbers.
 *
 * 906609
 *)

structure Pr004 =
struct

fun solve () = let
  fun loop (a, largest) = let
    fun iloop (b, largest) =
	if b > 999 then largest
	else let
	  val tmp = a * b
	in
	  if tmp > largest andalso Misc.isPalindrome (tmp, 10) then
	    iloop (b+1, tmp)
	  else
	    iloop (b+1, largest)
	end
  in
    if a > 999 then largest
    else loop (a+1, iloop (a, largest))
  end
in loop (1, 0)
end

(* val () = print (Int.toString (solve ()) ^ "\n") *)
end
