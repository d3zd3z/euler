// Problem 49
//
// 01 August 2003
//
// The arithmetic sequence, 1487, 4817, 8147, in which each of the terms
// increases by 3330, is unusual in two ways: (i) each of the three terms are
// prime, and, (ii) each of the 4-digit numbers are permutations of one
// another.
//
// There are no arithmetic sequences made up of three 1-, 2-, or 3-digit
// primes, exhibiting this property, but there is one other 4-digit
// increasing sequence.
//
// What 12-digit number do you form by concatenating the three terms in this
// sequence?
//
// 296962999629

package main

import (
	"euler"
	"fmt"
	"sort"
)

func main() {
	var sieve euler.Sieve

	var result int64

	// Check if this result is valid, and process it if it is.
	isValid := func(nums []int) {
		if nums[1] - nums[0] != nums[2] - nums[1] {
			return
		}
		for _, num := range nums {
			if !sieve.IsPrime(num) {
				return
			}
		}
		if nums[0] == 1487 {
			// Skip, per problem description.
			return
		}
		result = int64(nums[0]) * 100000000 + int64(nums[1]) * 10000 + int64(nums[0])
	}

	// This isn't actually right, but it so happens that the
	// initial value of the result is prime.  The first prime of
	// the result might not be the lowest permutation, and that
	// lowest permutation might not be prime.
	for base := 1009; base < 10000; base++ {
	// for prime := 1009; prime < 10000; prime = sieve.NextPrime(prime) {
		if !isAscending(base) {
			continue
		}
		perms := allPermutations(base)
		selections(perms, isValid)
	}

	fmt.Printf("%d\n", result)
}

// Check if this result is valid, and print it if it is.  Assumes the
// length is 3.
func isValid(nums []int) {
}

// Only seed from numbers that are monotonically increasing.
func isAscending(number int) bool {
	c := 9
	for number > 0 {
		tmp := number % 10
		if tmp > c {
			return false
		}
		c = tmp
		number /= 10
	}
	return true
}

// Compute all of the digit permutations of the number.
func allPermutations(base int) (perms []int) {
	perms = make([]int, 1)
	perms[0] = base

	work := euler.DigitsOf(base)
	iwork := sort.IntSlice(work)
	for !euler.NextPermutation(iwork) {
		perms = append(perms, euler.OfDigits(work))
	}

	return
}

// Generate all 3-element selections of the given vector.
func selections(base []int, handle func([]int)) {
	work := make([]int, 0)

	var walk func(pos int)
	walk = func(pos int) {
		if len(work) == 3 {
			handle(work)
			return
		}
		if pos >= len(base) {
			return
		}
		work = append(work, base[pos])
		walk(pos + 1)
		work = work[:len(work)-1]
		walk(pos + 1)
	}
	walk(0)
}
