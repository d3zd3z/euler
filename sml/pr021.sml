(*
 * Problem 21
 *
 * 05 July 2002
 *
 *
 * Let d(n) be defined as the sum of proper divisors of n (numbers less
 * than n which divide evenly into n).
 * If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable
 * pair and each of a and b are called amicable numbers.
 *
 * For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20,
 * 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of
 * 284 are 1, 2, 4, 71 and 142; so d(284) = 220.
 *
 * Evaluate the sum of all the amicable numbers under 10000.
 *
 * 31626
 *)

fun properDivisorSum (sv, n) =
    let val divs = Sieve.divisors (sv, n)
	val sum = foldl (op +) 0 divs
    in
      sum - n
    end

fun isAmicable (sv, a) =
    let val b = properDivisorSum (sv, a)
    in
      if a = b orelse b = 0 then false
      else
	let val c = properDivisorSum (sv, b) in
	  a = c
	end
    end

fun euler021 () =
    let val sv = Sieve.make 1000
	fun loop (10000, result) = result
	  | loop (i, result) = loop (i+1, if isAmicable (sv, i) then result + i else result)
    in
      loop (1, 0)
    end

val () = print (Int.toString (euler021 ()) ^ "\n")
