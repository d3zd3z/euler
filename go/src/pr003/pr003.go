//////////////////////////////////////////////////////////////////////
// Problem 3
// 
// 02 November 2001
// 
// The prime factors of 13195 are 5, 7, 13 and 29.
// 
// What is the largest prime factor of the number 600851475143 ?
// 
//////////////////////////////////////////////////////////////////////

// The input number fits in an Int64.

package main

import "fmt"
import "euler"

import "log"
import "os"
import "runtime/pprof"

const start int64 = 600851475143

func main() {
	var sieve euler.Sieve

	num := start
	var prime int = 2
	for {
		if num == int64(prime) {
			fmt.Printf("%d\n", prime)
			break
		}

		// Divide out the prime as many times as possible.
		for num%int64(prime) == 0 {
			num /= int64(prime)
		}

		prime = sieve.NextPrime(prime)
	}
}

func omain() {
	f, err := os.Create("profile.out")
	if err != nil {
		log.Fatal("Cannot create profile")
	}
	pprof.StartCPUProfile(f)
	defer pprof.StopCPUProfile()

	var sieve euler.SieveHeap

	num := start
	for {
		prime := sieve.Next()
		if num == prime {
			fmt.Printf("%d\n", prime)
			break
		}

		// Divide out the prime as many times as possible.
		for num%prime == 0 {
			num /= prime
		}
	}

	// for i := 0; i < 100; i++ {
	// 	fmt.Printf("%8d\n", sieve.Next())
	// }
	bench()
}

func bench() {
	var sieve euler.SieveHeap

	stop := int64(10000000)
	for {
		prime := sieve.Next()
		if prime >= stop {
			// fmt.Printf("%v\n", sieve)
			return
		}
	}
}

// Integer square root of a "big" number.
// Turns out to not be needed.
func isqrt(num int64) (result int64) {
	bit := int64(1)
	for (bit << 2) < num {
		bit <<= 2
	}

	for bit != 0 {
		if num >= result+bit {
			num -= result + bit
			result = (result >> 1) + bit
		} else {
			result >>= 1
		}
		bit >>= 2
	}
	return
}
