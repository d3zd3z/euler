//////////////////////////////////////////////////////////////////////
// Problem 10
// 
// 08 February 2002
// 
// The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
// 
// Find the sum of all the primes below two million.
// 
//////////////////////////////////////////////////////////////////////

package main

import (
	"euler"
	"fmt"
)

func main() {
	sum := int64(0)
	var sieve euler.Sieve
	for prime := 2; prime < 2000000; prime = sieve.NextPrime(prime) {
		sum += int64(prime)
	}
	fmt.Printf("%d\n", sum)
}

func omain() {
	sum := int64(0)
	var sieve euler.SieveHeap
	for {
		prime := sieve.Next()
		if prime >= 2000000 {
			break
		}
		sum += prime
	}
	fmt.Printf("%d\n", sum)
}
