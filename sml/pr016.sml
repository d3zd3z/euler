(*
 * Problem 16
 *
 * 03 May 2002
 *
 *
 * 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
 *
 * What is the sum of the digits of the number 2^1000?
 *
 * 1366
 *)

fun digitSum (n : IntInf.int) =
    let fun loop (0, result) = result
	  | loop (n, result) = loop (n div 10, result + (n mod 10))
    in
      loop (n, 0)
    end

(* TODO: Use a more efficient exponent function. *)
fun expt (n : IntInf.int, power) =
    let fun loop (result, 0) = result
	  | loop (result, p) = loop(result * n, p-1)
    in
      loop(1, power)
    end

fun euler016 () = digitSum (expt (2, 1000))

val () = print (IntInf.toString (euler016 ()) ^ "\n")
