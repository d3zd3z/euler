//////////////////////////////////////////////////////////////////////
// Problem 27
//
// Published on Friday, 27th September 2002, 06:00 pm; Solved by 32557
//
// Euler published the remarkable quadratic formula:
//
// n^2 + n + 41
//
// It turns out that the formula will produce 40 primes for the
// consecutive values n = 0 to 39. However, when n = 40, 40^2 + 40 + 41
// = 40(40 + 1) + 41 is divisible by 41, and certainly when n = 41, 41
// ^2 + 41 + 41 is clearly divisible by 41.
//
// Using computers, the incredible formula  n^2 − 79n + 1601 was
// discovered, which produces 80 primes for the consecutive values n =
// 0 to 79. The product of the coefficients, −79 and 1601, is −126479.
//
// Considering quadratics of the form:
//
//     n^2 + an + b, where |a| < 1000 and |b| < 1000
//
//     where |n| is the modulus/absolute value of n
//     e.g. |11| = 11 and |−4| = 4
//
// Find the product of the coefficients, a and b, for the quadratic
// expression that produces the maximum number of primes for
// consecutive values of n, starting with n = 0.
//
//////////////////////////////////////////////////////////////////////
// -59231

package pr027

import "github.com/d3zd3z/euler/go/euler"
import "fmt"

func Run() {
	var sieve euler.Sieve

	largest := 0
	largestResult := 0

	for a := -999; a < 1000; a++ {
		for b := -999; b < 1000; b++ {
			count := longestSeries(&sieve, a, b)
			if count > largest {
				largest = count
				largestResult = a * b
			}
		}
	}

	fmt.Printf("%d\n", largestResult)
}

func longestSeries(sieve *euler.Sieve, a, b int) int {
	for n := 0; ; n++ {
		c := n*n + a*n + b
		if c < 2 || !sieve.IsPrime(c) {
			return n
		}
	}
	panic("Not reached")
}
