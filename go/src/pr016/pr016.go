//////////////////////////////////////////////////////////////////////
// Problem 16
// 
// 03 May 2002
// 
// 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
// 
// What is the sum of the digits of the number 2^1000?
// 
//////////////////////////////////////////////////////////////////////
// 1366

// Two ways of doing this.  We can compute it ourselves, or we can
// just use bignums.

package main

import "fmt"
import "math/big"

func main() {
	num := big.NewInt(1)
	factor := big.NewInt(2)

	for x := 0; x < 1000; x++ {
		num.Mul(num, factor)
	}

	total := 0
	zero := big.NewInt(0)
	ten := big.NewInt(10)
	tmp := new(big.Int)

	for num.Cmp(zero) > 0 {
		num.QuoRem(num, ten, tmp)
		total += int(tmp.Int64())
	}

	fmt.Printf("%d\n", total)
}
