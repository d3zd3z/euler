(*
 * Problem 9
 *
 * 25 January 2002
 *
 *
 * A Pythagorean triplet is a set of three natural numbers, a < b < c,
 * for which,
 *
 * a^2 + b^2 = c^2
 *
 * For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
 *
 * There exists exactly one Pythagorean triplet for which a + b + c =
 * 1000.
 * Find the product abc.
 *
 * 31875000
 *)

fun euler9 () =
    let
      fun oloop a =
	  let
	    fun iloop b =
		if b >= 1000 then oloop (a+1)
		else let
		  val c = 1000 - a - b
		in
		  if c > b andalso c*c = a*a + b*b then
		    a * b * c
		  else
		    iloop (b+1)
		end
	  in
	    iloop a
	  end
    in
      oloop 1
    end

val () = print (Int.toString (euler9 ()) ^ "\n")
