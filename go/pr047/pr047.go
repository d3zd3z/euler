//////////////////////////////////////////////////////////////////////
// Problem 47
//
// 04 July 2003
//
// The first two consecutive numbers to have two distinct prime factors
// are:
//
// 14 = 2 × 7
// 15 = 3 × 5
//
// The first three consecutive numbers to have three distinct prime
// factors are:
//
// 644 = 2² × 7 × 23
// 645 = 3 × 5 × 43
// 646 = 2 × 17 × 19.
//
// Find the first four consecutive integers to have four distinct
// primes factors. What is the first of these numbers?
//
//////////////////////////////////////////////////////////////////////
// 134043

package pr047

import (
	"fmt"
	"github.com/d3zd3z/euler/go/euler"
)

const expect = 4

func Run() {
	var sieve euler.Sieve

	count := 0
	for i := 2; ; i++ {
		factors := sieve.Factorize(i)
		if len(factors) == expect {
			count += 1
			if count == expect {
				fmt.Printf("%d\n", i-expect+1)
				return
			}
		} else {
			count = 0
		}
	}
}
