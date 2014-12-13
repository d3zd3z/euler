//////////////////////////////////////////////////////////////////////
// Problem 50
//
// 15 August 2003
//
// The prime 41, can be written as the sum of six consecutive primes:
//
// 41 = 2 + 3 + 5 + 7 + 11 + 13
//
// This is the longest sum of consecutive primes that adds to a prime
// below one-hundred.
//
// The longest sum of consecutive primes below one-thousand that adds
// to a prime, contains 21 terms, and is equal to 953.
//
// Which prime, below one-million, can be written as the sum of the
// most consecutive primes?
//
//////////////////////////////////////////////////////////////////////
//
// 997651

package pr050

import (
	"euler"
	"fmt"
)

func Run() {
	var sieve euler.Sieve
	limit := 1000000
	ps := sieve.PrimesUpto(limit)

	longestLen := 0
	longestVal := 0

	for a := 1; a < len(ps); a++ {
		total := 0
		for b := a; b < len(ps); b++ {
			total += ps[b]
			if total >= limit {
				break
			}

			if b-a+1 > longestLen && sieve.IsPrime(total) {
				longestLen = b-a+1
				longestVal = total
			}
		}
	}

	fmt.Printf("%d\n", longestVal)
}
