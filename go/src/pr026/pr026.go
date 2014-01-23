//////////////////////////////////////////////////////////////////////
// Problem 26
//
// Published on Friday, 13th September 2002, 06:00 pm; Solved by 30795
//
// A unit fraction contains 1 in the numerator. The decimal
// representation of the unit fractions with denominators 2 to 10 are
// given:
//
//     ^1/[2]  =  0.5
//     ^1/[3]  =  0.(3)
//     ^1/[4]  =  0.25
//     ^1/[5]  =  0.2
//     ^1/[6]  =  0.1(6)
//     ^1/[7]  =  0.(142857)
//     ^1/[8]  =  0.125
//     ^1/[9]  =  0.(1)
//     ^1/[10] =  0.1
//
// Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle.
// It can be seen that ^1/[7] has a 6-digit recurring cycle.
//
// Find the value of d < 1000 for which ^1/[d] contains the longest
// recurring cycle in its decimal fraction part.
//
//////////////////////////////////////////////////////////////////////
// 983

package main

import "euler"
import "fmt"

func main() {
	var sieve euler.Sieve
	largest := 0
	largestValue := 0

	for p := 7; p < 1000; p = sieve.NextPrime(p) {
		size := dlog(p)
		if size > largest {
			largest = size
			largestValue = p
		}
	}

	fmt.Printf("%d\n", largestValue)
}

// Find the value 'k' such that 10^k = 1 (mod N).  Will not terminate
// if 'n' is a factor of 10.
func dlog(n int) (k int) {
	k = 1
	temp := 10 % n
	for temp > 1 {
		k++
		temp = (temp * 10) % n
	}
	return
}
