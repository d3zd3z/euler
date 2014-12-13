//////////////////////////////////////////////////////////////////////
// Problem 21
//
// Published on Friday, 5th July 2002, 06:00 pm; Solved by 53700
//
// Let d(n) be defined as the sum of proper divisors of n (numbers less
// than n which divide evenly into n).
// If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable
// pair and each of a and b are called amicable numbers.
//
// For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20,
// 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of
// 284 are 1, 2, 4, 71 and 142; so d(284) = 220.
//
// Evaluate the sum of all the amicable numbers under 10000.
//
//////////////////////////////////////////////////////////////////////

package pr021

import "euler"
import "fmt"

const limit = 10000

func Run() {
	var sieve euler.Sieve

	sum := 0
	for i := 2; i < limit; i++ {
		if isAmicable(&sieve, i) {
			sum += i
		}
	}
	fmt.Printf("%d\n", sum)
}

func isAmicable(s *euler.Sieve, a int) bool {
	if a >= limit {
		return false
	}
	b := s.ProperDivisorSum(a)
	if b >= limit || a == b {
		return false
	}
	c := s.ProperDivisorSum(b)
	return a == c
}
