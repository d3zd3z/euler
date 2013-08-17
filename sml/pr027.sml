(*
 * Problem 27
 *
 * 27 September 2002
 *
 *
 * Euler published the remarkable quadratic formula:
 *
 * n^2 + n + 41
 *
 * It turns out that the formula will produce 40 primes for the
 * consecutive values n = 0 to 39. However, when n = 40, 40^2 + 40 + 41
 * = 40(40 + 1) + 41 is divisible by 41, and certainly when n = 41, 41
 * ^2 + 41 + 41 is clearly divisible by 41.
 *
 * Using computers, the incredible formula  n^2 − 79n + 1601 was
 * discovered, which produces 80 primes for the consecutive values n =
 * 0 to 79. The product of the coefficients, −79 and 1601, is −126479.
 *
 * Considering quadratics of the form:
 *
 *     n^2 + an + b, where |a| < 1000 and |b| < 1000
 *
 *     where |n| is the modulus/absolute value of n
 *     e.g. |11| = 11 and |−4| = 4
 *
 * Find the product of the coefficients, a and b, for the quadratic
 * expression that produces the maximum number of primes for
 * consecutive values of n, starting with n = 0.
 *
 * -59231
 *)

structure Pr027 =
struct

fun countPrimes (sieve, a, b) =
    let fun loop n =
	    let val p = n*n + a*n + b in
	      if p < 2 orelse not (Sieve.isPrime (sieve, p)) then n
	      else loop (n + 1)
	    end
    in loop 0 end

fun solve () =
    let val sieve = Sieve.make 1024
	fun aloop (_, largestResult, 1000) = largestResult
	  | aloop (largest, largestResult, a) =
	    let fun bloop (largest, largestResult, 1000) = (largest, largestResult)
		  | bloop (largest, largestResult, b) =
		    let val count = countPrimes (sieve, a, b) in
		      if count > largest then
			bloop (count, a * b, b + 1)
		      else
			bloop (largest, largestResult, b + 1)
		    end
		val (largest', largestResult') = bloop (largest, largestResult, ~999)
	    in
	      aloop (largest', largestResult', a + 1)
	    end
    in
      aloop (0, ~1, ~999)
    end

end
