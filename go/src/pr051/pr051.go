//////////////////////////////////////////////////////////////////////
// Problem 51
// 
// 29 August 2003
// 
// By replacing the 1^st digit of *3, it turns out that six of the nine
// possible values: 13, 23, 43, 53, 73, and 83, are all prime.
// 
// By replacing the 3^rd and 4^th digits of 56**3 with the same digit,
// this 5-digit number is the first example having seven primes among
// the ten generated numbers, yielding the family: 56003, 56113, 56333,
// 56443, 56663, 56773, and 56993. Consequently 56003, being the first
// member of this family, is the smallest prime with this property.
// 
// Find the smallest prime which, by replacing part of the number (not
// necessarily adjacent digits) with the same digit, is part of an
// eight prime value family.
// 
// 121313
//////////////////////////////////////////////////////////////////////

package pr051

import (
	"euler"
	"fmt"
)

func Run() {
	var sieve euler.Sieve

	base := 2
	for {
		size := familySize(&sieve, base, 1)
		if size >= 8 {
			break
		}

		base = sieve.NextPrime(base)
	}

	fmt.Printf("%d\n", base)
}

func familySize(sieve *euler.Sieve, base, part int) (size int) {
	orig := euler.DigitsOf(base)
	work := make([]int, len(orig))
	size = 0

	found := false
	for _, d := range orig {
		if d == part {
			found = true
			break
		}
	}
	if !found {
		return
	}

	for value := part; value <= 9; value++ {
		copy(work, orig)
		for i := range orig {
			if work[i] == part {
				work[i] = value
			}
		}

		prime := euler.OfDigits(work)
		if sieve.IsPrime(prime) {
			size++
		}
	}
	return
}
