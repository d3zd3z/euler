(*
 * Problem 20
 *
 * 21 June 2002
 *
 *
 * n! means n x (n − 1) x ... x 3 x 2 x 1
 *
 * For example, 10! = 10 x 9 x ... x 3 x 2 x 1 = 3628800,
 * and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0
 * + 0 = 27.
 *
 * Find the sum of the digits in the number 100!
 *
 * 648
 *)

(* The easy solution is to just use IntInf.int *)

structure I = IntInf

fun fact (n : I.int) =
    let fun loop (0, result) = result
	  | loop (n, result) = loop (n-1, result * n)
    in
      loop (n, 1)
    end

fun digitSum (n : I.int) =
    let fun loop (0, result) = result
	  | loop (n, result) = loop (n div 10, result + (n mod 10))
    in
      loop (n, 0)
    end

fun euler020 () = digitSum (fact 100)

val () = print (I.toString (euler020 ()) ^ "\n")
