//////////////////////////////////////////////////////////////////////
// Problem 7
// 
// 28 December 2001
// 
// By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we
// can see that the 6th prime is 13.
// 
// What is the 10 001st prime number?
// 
//////////////////////////////////////////////////////////////////////

package main

import (
	"euler"
	"fmt"
)

func main() {
	var sieve euler.Sieve

	prime := 2
	for i := 0; i < 10000; i++ {
		prime = sieve.NextPrime(prime)
	}
	fmt.Printf("%d\n", prime)
}

func omain() {
	var sieve euler.SieveHeap

	for i := 0; i < 10000; i++ {
		sieve.Next()
	}
	fmt.Printf("%d\n", sieve.Next())
}
