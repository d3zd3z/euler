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

fun reverse_digits n =
    let
      fun loop (n, result) =
	  if n > 0 then
	    loop (n div 10, result * 10 + n mod 10)
	  else
	    result
    in loop (n, 0)
    end

fun is_palindrome n = n = reverse_digits n

fun solve () = let
  fun loop (a, largest) = let
    fun iloop (b, largest) =
	if b > 999 then largest
	else let
	  val tmp = a * b
	in
	  if tmp > largest andalso is_palindrome tmp then
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

val () = print (Int.toString (solve ()) ^ "\n")
