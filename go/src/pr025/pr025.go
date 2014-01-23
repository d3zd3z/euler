//////////////////////////////////////////////////////////////////////
// Problem 25
//
// Published on Friday, 30th August 2002, 06:00 pm; Solved by 59566
//
// The Fibonacci sequence is defined by the recurrence relation:
//
//     F[n] = F[n−1] + F[n−2], where F[1] = 1 and F[2] = 1.
//
// Hence the first 12 terms will be:
//
//     F[1] = 1
//     F[2] = 1
//     F[3] = 2
//     F[4] = 3
//     F[5] = 5
//     F[6] = 8
//     F[7] = 13
//     F[8] = 21
//     F[9] = 34
//     F[10] = 55
//     F[11] = 89
//     F[12] = 144
//
// The 12th term, F[12], is the first term to contain three digits.
//
// What is the first term in the Fibonacci sequence to contain 1000
// digits?
//
//////////////////////////////////////////////////////////////////////
// 4782

package main

import "fmt"

// Represent the numbers in base 10, using just bytes for each digit.
// The digit value has to be large enough to not overflow when added.

func main() {
	a := make([]int, 999)
	a[0] = 1

	b := make([]int, 999)
	b[0] = 1

	count := 2
	for {
		count++
		carry := add(a, b)
		if carry > 0 {
			break
		}
		a, b = b, a
	}
	fmt.Printf("%d\n", count)
}

// Add b to a, putting the result in a.
func add(a []int, b []int) int {
	carry := 0
	for i := range a {
		tmp := a[i] + b[i] + carry
		a[i] = tmp % 10
		carry = tmp / 10
	}
	return carry
}
