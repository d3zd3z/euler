//////////////////////////////////////////////////////////////////////
// Problem 52
//
// 12 September 2003
//
// It can be seen that the number, 125874, and its double, 251748,
// contain exactly the same digits, but in a different order.
//
// Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and
// 6x, contain the same digits.
//
//////////////////////////////////////////////////////////////////////

package pr052

import (
	"fmt"
	"github.com/d3zd3z/euler/go/euler"
)

func Run() {
Outer:
	for b := 100000; b < 200000; b++ {
		bval := numberValue(b)
		for p := 2; p < 7; p++ {
			pval := numberValue(b * p)
			if bval != pval {
				continue Outer
			}
		}
		fmt.Printf("%d\n", b)
		break
	}
}

var earlyPrimes []int

// Generate a unique identifier for a given (small) number that
// doesn't account for the position of the digits, just which digits
// and how many of each.
func numberValue(num int) (value int64) {
	value = 1
	for num > 0 {
		tmp := num % 10
		num /= 10
		value *= int64(earlyPrimes[tmp])
	}
	return
}

func init() {
	earlyPrimes = make([]int, 10)
	var sieve euler.Sieve
	p := 2
	for i := range earlyPrimes {
		earlyPrimes[i] = p
		p = sieve.NextPrime(p)
	}
	return
}
