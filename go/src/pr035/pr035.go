//////////////////////////////////////////////////////////////////////
// Problem 35
//
// Published on Friday, 17th January 2003, 06:00 pm; Solved by 35138
//
// The number, 197, is called a circular prime because all rotations of
// the digits: 197, 971, and 719, are themselves prime.
//
// There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17,
// 31, 37, 71, 73, 79, and 97.
//
// How many circular primes are there below one million?
//
//////////////////////////////////////////////////////////////////////
// 55

package main

import "fmt"
import "euler"

func main() {
	var s euler.Sieve

	p := 2
	count := 0

	// Move the closure out of the loop for efficiency.  It does
	// save some time.
	circular := true
	pcheck := func(num int) {
		if !s.IsPrime(num) {
			circular = false
		}
	}

	for p < 1000000 {
		circular = true
		eachRotation(p, pcheck)

		if circular {
			// fmt.Printf("%d\n", p)
			count++
		}
		p = s.NextPrime(p)
	}

	fmt.Printf("%d\n", count)
}

// Call 'act' for each of the rotations of the given number.
func eachRotation(number int, act func(int)) {
	right := countDigits(number)
	rightExp := simpleExp(10, right)
	leftExp := 1
	accum := 0
	for right > 0 {
		act(number + rightExp*accum)
		accum += leftExp * (number % 10)
		number /= 10
		right--
		rightExp /= 10
		leftExp *= 10
	}
}

// Count how many digits are in the given positive number.
func countDigits(number int) (result int) {
	for number > 0 {
		result++
		number /= 10
	}
	return
}

func simpleExp(base int, expt int) (result int) {
	result = 1
	for expt > 0 {
		result *= base
		expt -= 1
	}
	return
}
