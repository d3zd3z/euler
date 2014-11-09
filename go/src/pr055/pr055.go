//////////////////////////////////////////////////////////////////////
// Problem 55
// 
// 24 October 2003
// 
// If we take 47, reverse and add, 47 + 74 = 121, which is palindromic.
// 
// Not all numbers produce palindromes so quickly. For example,
// 
// 349 + 943 = 1292,
// 1292 + 2921 = 4213
// 4213 + 3124 = 7337
// 
// That is, 349 took three iterations to arrive at a palindrome.
// 
// Although no one has proved it yet, it is thought that some numbers,
// like 196, never produce a palindrome. A number that never forms a
// palindrome through the reverse and add process is called a Lychrel
// number. Due to the theoretical nature of these numbers, and for the
// purpose of this problem, we shall assume that a number is Lychrel
// until proven otherwise. In addition you are given that for every
// number below ten-thousand, it will either (i) become a palindrome in
// less than fifty iterations, or, (ii) no one, with all the computing
// power that exists, has managed so far to map it to a palindrome. In
// fact, 10677 is the first number to be shown to require over fifty
// iterations before producing a palindrome:
// 4668731596684224866951378664 (53 iterations, 28-digits).
// 
// Surprisingly, there are palindromic numbers that are themselves
// Lychrel numbers; the first example is 4994.
// 
// How many Lychrel numbers are there below ten-thousand?
// 
// NOTE: Wording was modified slightly on 24 April 2007 to emphasise
// the theoretical nature of Lychrel numbers.
// 
// 249
//////////////////////////////////////////////////////////////////////

package main

import (
	"fmt"
	"math/big"
)

func main() {
	count := 0
	for i := 1; i < 10000; i++ {
		_, stop := countLen(i)
		if !stop {
			count++
		}
	}
	fmt.Printf("%d\n", count)
}

func countLen(n int) (count int, stopped bool) {
	work := big.NewInt(int64(n))

	for count = 1; count <= 50; count++ {
		tmp := reverse(work)
		work.Add(work, tmp)

		tmp = reverse(work)
		if work.Cmp(tmp) == 0 {
			stopped = true
			return
		}
	}

	return
}

var zero = big.NewInt(0)
var ten = big.NewInt(10)

// TODO: Pass in result, so it can be reused.
func reverse(n *big.Int) (result *big.Int) {
	result = big.NewInt(0)
	var work big.Int
	work.Add(n, zero)
	tmp := big.NewInt(0)

	for work.Cmp(zero) != 0 {
		work.DivMod(&work, ten, tmp)
		result.Mul(result, ten)
		result.Add(result, tmp)
	}
	return
}
