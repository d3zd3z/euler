//////////////////////////////////////////////////////////////////////
// Problem 57
//
// 21 November 2003
//
// It is possible to show that the square root of two can be expressed
// as an infinite continued fraction.
//
// √ 2 = 1 + 1/(2 + 1/(2 + 1/(2 + ... ))) = 1.414213...
//
// By expanding this for the first four iterations, we get:
//
// 1 + 1/2 = 3/2 = 1.5
// 1 + 1/(2 + 1/2) = 7/5 = 1.4
// 1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 1.41666...
// 1 + 1/(2 + 1/(2 + 1/(2 + 1/2))) = 41/29 = 1.41379...
//
// The next three expansions are 99/70, 239/169, and 577/408, but the
// eighth expansion, 1393/985, is the first example where the number of
// digits in the numerator exceeds the number of digits in the
// denominator.
//
// In the first one-thousand expansions, how many fractions contain a
// numerator with more digits than denominator?
//
// 153
//////////////////////////////////////////////////////////////////////

package pr057

import (
	"fmt"
	"math/big"
)

func Run() {
	s := big.NewRat(3, 2)
	one := big.NewRat(1, 1)

	count := 0
	for i := 1; i < 1000; i++ {
		s.Add(s, one)
		s.Inv(s)
		s.Add(s, one)

		if digitCount(s.Num()) > digitCount(s.Denom()) {
			count += 1
		}
	}

	fmt.Printf("%d\n", count)
}

func digitCount(n *big.Int) int {
	zero := big.NewInt(0)
	ten := big.NewInt(10)
	var work big.Int
	work.Set(n)
	tmp := big.NewInt(0)

	count := 0

	for work.Cmp(zero) > 0 {
		work.DivMod(&work, ten, tmp)
		count += 1
	}

	return count
}
