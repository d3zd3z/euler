//////////////////////////////////////////////////////////////////////
// Problem 41
//
// Published on Friday, 11th April 2003, 06:00 pm; Solved by 27758
//
// We shall say that an n-digit number is pandigital if it makes use of
// all the digits 1 to n exactly once. For example, 2143 is a 4-digit
// pandigital and is also prime.
//
// What is the largest n-digit pandigital prime that exists?
//
//////////////////////////////////////////////////////////////////////
// 7652413

package pr041

import (
	"fmt"

	"github.com/d3zd3z/euler/go/euler"
)

// 8 and 9 digit pandigital numbers will always be divisible by 3, so
// the largest this can be is a 7-digit number.

func Run() {
	var sv euler.Sieve

	largest := 0
	for p := 2; p < 9999999; p = sv.NextPrime(p) {
		if isPandigital(p) {
			largest = p
		}
	}

	fmt.Printf("%d\n", largest)
}

func isPandigital(num int) bool {
	digits := make([]int, 10)

	count := 0
	for num > 0 {
		digits[num%10]++
		count++
		num /= 10
	}

	if digits[0] != 0 {
		return false
	}

	for i := 1; i <= count; i++ {
		if digits[i] != 1 {
			return false
		}
	}

	// This test isn't necessary, because if the above passes,
	// this must be true.
	// for i := count + 1; i < 10; i++ {
	// 	if digits[i] != 0 {
	// 		return false
	// 	}
	// }

	return true
}
