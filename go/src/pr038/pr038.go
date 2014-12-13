//////////////////////////////////////////////////////////////////////
// Problem 38
//
// Published on Friday, 28th February 2003, 06:00 pm; Solved by 24946
//
// Take the number 192 and multiply it by each of 1, 2, and 3:
//
//     192 x 1 = 192
//     192 x 2 = 384
//     192 x 3 = 576
//
// By concatenating each product we get the 1 to 9 pandigital,
// 192384576. We will call 192384576 the concatenated product of 192
// and (1,2,3)
//
// The same can be achieved by starting with 9 and multiplying by 1, 2,
// 3, 4, and 5, giving the pandigital, 918273645, which is the
// concatenated product of 9 and (1,2,3,4,5).
//
// What is the largest 1 to 9 pandigital 9-digit number that can be
// formed as the concatenated product of an integer with (1,2, ... , n)
// where n > 1?
//
//////////////////////////////////////////////////////////////////////
// 932718654

package pr038

import "fmt"

func Run() {
	largest := int64(0)

	for base := int64(1); base < 10000; base++ {
		pand, ok := products(base)
		if ok && pand > largest {
			largest = pand
		}
	}
	fmt.Printf("%d\n", largest)
}

// Given a base, return true if the product can make a pandatigal, and
// set pand to that value.
func products(base int64) (pand int64, ok bool) {
	var work int64 = 0

	mult := int64(1)
	for work < largest {
		work = concat(work, base * mult)
		if isPandigital(work) {
			return work, true
		}
		mult++
	}

	return 0, false
}

// Concatenate two numbers.
func concat(left, right int64) (result int64) {
	result = left
	tmp := right
	for tmp > 0 {
		result *= 10
		tmp /= 10
	}
	result += right
	return
}

// Is this given number pandigital.
func isPandigital(number int64) bool {
	var prod int64 = 1

	for number > 0 {
		tmp := int(number % 10)
		number /= 10
		prod *= primes[tmp]
	}

	return prod == pandigital
}

// Given a 'key', take each digit from 'number', and augment by the
// primes list.
func augment(base int64, number int) (result int64) {
	return
}

var primes = []int64{2, 3, 5, 7, 11, 13, 17, 19, 23, 29}
const pandigital = 3 * 5 * 7 * 11 * 13 * 17 * 19 * 23 * 29
const largest = 987654321
