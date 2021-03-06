//////////////////////////////////////////////////////////////////////
// Problem 44
//
// 23 May 2003
//
// Pentagonal numbers are generated by the formula, P[n]=n(3n−1)/2. The
// first ten pentagonal numbers are:
//
// 1, 5, 12, 22, 35, 51, 70, 92, 117, 145, ...
//
// It can be seen that P[4] + P[7] = 22 + 70 = 92 = P[8]. However,
// their difference, 70 − 22 = 48, is not pentagonal.
//
// Find the pair of pentagonal numbers, P[j] and P[k], for which their
// sum and difference is pentagonal and D = |P[k] − P[j]| is minimised;
// what is the value of D?
//
//////////////////////////////////////////////////////////////////////
// 5482660

package pr044

import (
	"fmt"
	"github.com/d3zd3z/euler/go/euler"
)

func Run() {
	for i := 2; ; i++ {
		pentI := NthPentagonal(i)
		for j := 1; j < i; j++ {
			pentJ := NthPentagonal(j)

			if IsPentagonal(pentI-pentJ) &&
				IsPentagonal(pentI+pentJ) {
				fmt.Printf("%d\n", pentI-pentJ)
				return
			}
		}
	}
}

func NthPentagonal(num int) int {
	return num * (3*num - 1) / 2
}

func IsPentagonal(num int) bool {
	sq := num*24 + 1
	root := euler.ISqrt(sq)
	return (root*root == sq) &&
		((root+1)%6) == 0
}
