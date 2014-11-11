//////////////////////////////////////////////////////////////////////
// Problem 56
// 
// 07 November 2003
// 
// A googol (10^100) is a massive number: one followed by one-hundred
// zeros; 100^100 is almost unimaginably large: one followed by
// two-hundred zeros. Despite their size, the sum of the digits in each
// number is only 1.
// 
// Considering natural numbers of the form, a^b, where a, b < 100, what
// is the maximum digital sum?
// 
// 972
//////////////////////////////////////////////////////////////////////

package main

import (
	"fmt"
	"math/big"
)

func main() {
	longest := 0
	for a := 1; a < 100; a++ {
		for b := 1; b < 100; b++ {
			aa := big.NewInt(int64(a))
			aa.Exp(aa, big.NewInt(int64(b)), nil)
			sum := digitSum(aa)
			if sum > longest {
				longest = sum
			}
		}
	}
	fmt.Printf("%d\n", longest)
}

func digitSum(num *big.Int) (sum int) {
	zero := big.NewInt(0)
	ten := big.NewInt(10)

	var work big.Int
	work.Set(num)

	tmp := big.NewInt(0)

	for work.Cmp(zero) > 0 {
		work.DivMod(&work, ten, tmp)
		sum += int(tmp.Int64())
	}
	return
}
