//////////////////////////////////////////////////////////////////////
// Problem 46
// 
// 20 June 2003
// 
// It was proposed by Christian Goldbach that every odd composite
// number can be written as the sum of a prime and twice a square.
// 
// 9 = 7 + 2x1^2
// 15 = 7 + 2x2^2
// 21 = 3 + 2x3^2
// 25 = 7 + 2x3^2
// 27 = 19 + 2x2^2
// 33 = 31 + 2x1^2
// 
// It turns out that the conjecture was false.
// 
// What is the smallest odd composite that cannot be written as the sum
// of a prime and twice a square?
// 
//////////////////////////////////////////////////////////////////////

package pr046

import (
	"euler"
	"fmt"
)

func Run() {
	var s euler.Sieve

	n := 9
	for ; ; n += 2 {
		if s.IsPrime(n) {
			continue
		}
		_, present := goldbach(&s, n)
		if !present {
			break
		}
	}
	fmt.Printf("%d\n", n)
}

// Return the first goldbach prime for the given number, if present.
func goldbach(sieve *euler.Sieve, number int) (result int, present bool) {
	for _, p := range sieve.PrimesUpto(number) {
		if (p == 2) {
			continue
		}
		_, perfect := perfect_root((number - p) / 2)
		if perfect {
			result = p
			present = true
			return
		}
	}
	return
}

// Return the ISqrt of the number, if the number is a perfect square,
// otherwise not.
func perfect_root(base int) (root int, perfect bool) {
	root = euler.ISqrt(base)
	perfect = (root * root == base)
	return
}