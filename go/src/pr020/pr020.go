//////////////////////////////////////////////////////////////////////
// Problem 20
//
// Published on Friday, 21st June 2002, 06:00 pm; Solved by 80405
//
// n! means n x (n − 1) x ... x 3 x 2 x 1
//
// For example, 10! = 10 x 9 x ... x 3 x 2 x 1 = 3628800,
// and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0
// + 0 = 27.
//
// Find the sum of the digits in the number 100!
//
//////////////////////////////////////////////////////////////////////
// 648

package main

import "fmt"

const base int = 10000

func main() {
	// Create the starting number 1, little endian.
	accumulator := make([]int, 40)
	accumulator[0] = 1

	for i := 2; i <= 100; i++ {
		multiply(accumulator, i)
	}

	sum := 0
	for i := 0; i < len(accumulator); i++ {
		temp := accumulator[i]
		for temp != 0 {
			sum += temp % 10
			temp /= 10
		}
	}

	fmt.Printf("%d\n", sum)
}

func multiply(accumulator []int, by int) {
	carry := 0
	for i := 0; i < len(accumulator); i++ {
		temp := accumulator[i]*by + carry
		accumulator[i] = temp % base
		carry = temp / base
	}
	if carry != 0 {
		panic("Accumulator overflow")
	}
}
