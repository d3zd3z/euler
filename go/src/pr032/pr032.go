//////////////////////////////////////////////////////////////////////
// Problem 32
//
// Published on Friday, 6th December 2002, 06:00 pm; Solved by 27197
//
// We shall say that an n-digit number is pandigital if it makes use of
// all the digits 1 to n exactly once; for example, the 5-digit number,
// 15234, is 1 through 5 pandigital.
//
// The product 7254 is unusual, as the identity, 39 x 186 = 7254,
// containing multiplicand, multiplier, and product is 1 through 9
// pandigital.
//
// Find the sum of all products whose multiplicand/multiplier/product
// identity can be written as a 1 through 9 pandigital.
//
// HINT: Some products can be obtained in more than one way so be sure
// to only include it once in your sum.
//
//////////////////////////////////////////////////////////////////////
// 45228

package main

import "euler"
import "fmt"
import "sort"

func main() {
	base := []int{1, 2, 3, 4, 5, 6, 7, 8, 9}

	sum := 0
	seen := make(map[int]bool)

	for {
		done := euler.NextPermutation(sort.IntSlice(base))
		if done {
			break
		}

		possible, product := isProduct(base)
		if possible && !seen[product] {
			sum += product
			seen[product] = true
		}
	}

	fmt.Printf("%d\n", sum)
}

// There are two possible ways of getting the ending sum, either
// nn*nnn=nnnn or n*nnnn=nnnn, so just check both of these.
func isProduct(a []int) (possible bool, product int) {
	product = 1000*a[5] + 100*a[6] + 10*a[7] + a[8]

	possible = ((10*a[0]+a[1])*(100*a[2]+10*a[3]+a[4]) == product) ||
		(a[0]*(1000*a[1]+100*a[2]+10*a[3]+a[4]) == product)
	return
}
