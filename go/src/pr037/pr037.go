//////////////////////////////////////////////////////////////////////
// Problem 37
//
// Published on Friday, 14th February 2003, 06:00 pm; Solved by 29331
//
// The number 3797 has an interesting property. Being prime itself, it
// is possible to continuously remove digits from left to right, and
// remain prime at each stage: 3797, 797, 97, and 7. Similarly we can
// work from right to left: 3797, 379, 37, and 3.
//
// Find the sum of the only eleven primes that are both truncatable
// from left to right and right to left.
//
// NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
//
//////////////////////////////////////////////////////////////////////
// 748317

package pr037

import "euler"
import "fmt"

func Run() {
	var s euler.Sieve

	count := 0
	sum := 0
	p := 11
	for count < 11 {
		if isRightPrime(&s, p) && isLeftPrime(&s, p) {
			sum += p
			count++
			// fmt.Printf("%d\n", p)
		}

		p = s.NextPrime(p)
	}
	fmt.Printf("%d\n", sum)
}

func isRightPrime(s *euler.Sieve, num int) bool {
	for num > 0 {
		if !s.IsPrime(num) {
			return false
		}
		num /= 10
	}
	return true
}

func isLeftPrime(s *euler.Sieve, num int) bool {
	mod := 1
	for mod < num {
		mod *= 10
	}

	for mod > 1 {
		num %= mod
		mod /= 10
		if !s.IsPrime(num) {
			return false
		}
	}

	return true
}
