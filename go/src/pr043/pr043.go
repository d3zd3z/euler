//////////////////////////////////////////////////////////////////////
// Problem 43
//
// 09 May 2003
//
// The number, 1406357289, is a 0 to 9 pandigital number because it is
// made up of each of the digits 0 to 9 in some order, but it also has
// a rather interesting sub-string divisibility property.
//
// Let d[1] be the 1^st digit, d[2] be the 2^nd digit, and so on. In
// this way, we note the following:
//
//   • d[2]d[3]d[4]=406 is divisible by 2
//   • d[3]d[4]d[5]=063 is divisible by 3
//   • d[4]d[5]d[6]=635 is divisible by 5
//   • d[5]d[6]d[7]=357 is divisible by 7
//   • d[6]d[7]d[8]=572 is divisible by 11
//   • d[7]d[8]d[9]=728 is divisible by 13
//   • d[8]d[9]d[10]=289 is divisible by 17
//
// Find the sum of all 0 to 9 pandigital numbers with this property.
//
//////////////////////////////////////////////////////////////////////
// 16695334890

package pr043

import (
	"euler"
	"fmt"
)

type intBase int64

var primes = []intBase{2, 3, 5, 7, 11, 13, 17}

func Run() {
	base := []intBase{0, 1, 2, 3, 4, 5, 6, 7, 8, 9}

	sum := intBase(0)
	for {
		done := euler.NextPermutation(intBaseSlice(base))
		if done {
			break
		}

		if check(base) {
			sum += numberOf(base)
		}
	}

	fmt.Printf("%d\n", sum)
}

func check(digits []intBase) bool {
	offset := 1
	for _, p := range primes {
		if numberOf(digits[offset:offset+3]) % p != 0 {
			return false
		}
		offset++
	}
	return true
}

func numberOf(digits []intBase) (result intBase) {
	for _, d := range digits {
		result = result * 10 + d
	}
	return
}

type intBaseSlice []intBase

func (p intBaseSlice) Len() int { return len(p) }
func (p intBaseSlice) Less(i, j int) bool { return p[i] < p[j] }
func (p intBaseSlice) Swap(i, j int) { p[i], p[j] = p[j], p[i] }
