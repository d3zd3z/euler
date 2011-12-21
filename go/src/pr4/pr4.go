//////////////////////////////////////////////////////////////////////
// Problem 4
// 
// 16 November 2001
// 
// A palindromic number reads the same both ways. The largest
// palindrome made from the product of two 2-digit numbers is 9009 = 91
// × 99.
// 
// Find the largest palindrome made from the product of two 3-digit
// numbers.
// 
//////////////////////////////////////////////////////////////////////

package main

import "fmt"

func main() {
	max := 0
	for a := 1; a < 1000; a++ {
		for b := a; b < 1000; b++ {
			prod := a * b
			if prod == reverseNum(prod) && prod > max {
				max = prod
			}
		}
	}
	fmt.Printf("%d\n", max)
}

// Only works for positive numbers.
func reverseNum(num int) (result int) {
	for num > 0 {
		result *= 10
		result += num % 10
		num /= 10
	}
	return
}
