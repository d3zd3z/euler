//////////////////////////////////////////////////////////////////////
// Problem 53
//
// 26 September 2003
//
// There are exactly ten ways of selecting three from five, 12345:
//
// 123, 124, 125, 134, 135, 145, 234, 235, 245, and 345
//
// In combinatorics, we use the notation, ^5C[3] = 10.
//
// In general,
//
// ^nC[r] = n!       ,where r ≤ n, n! = n×(n−1)×...×3×2×1, and 0! = 1.
//          r!(n−r)!
//
// It is not until n = 23, that a value exceeds one-million: ^23C[10] =
// 1144066.
//
// How many, not necessarily distinct, values of  ^nC[r], for 1 ≤ n ≤
// 100, are greater than one-million?
//
// 4075
//////////////////////////////////////////////////////////////////////

package main

import (
	"fmt"
)

func main() {
	buffer := make([]saturated, 101)
	buffer[0] = saturated(1)

	count := 0
	for i := 1; i <= 100; i++ {
		for j := i; j >= 1; j-- {
			buffer[j].Add(buffer[j-1])
			if buffer[j] == limit {
				count++
			}
		}
	}

	fmt.Printf("%d\n", count)
}

// Saturating numbers are just ints that never go above a particular
// value.  The requirement is that the int type can hold at least
// twice the saturated value
type saturated int

const limit = 1000001

func (p *saturated) Add(other saturated) {
	*p += other
	if *p >= limit {
		*p = limit
	}
}
