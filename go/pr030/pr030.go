//////////////////////////////////////////////////////////////////////
// Problem 30
//
// Published on Friday, 8th November 2002, 06:00 pm; Solved by 42426
//
// Surprisingly there are only three numbers that can be written as the
// sum of fourth powers of their digits:
//
//     1634 = 1^4 + 6^4 + 3^4 + 4^4
//     8208 = 8^4 + 2^4 + 0^4 + 8^4
//     9474 = 9^4 + 4^4 + 7^4 + 4^4
//
// As 1 = 1^4 is not a sum it is not included.
//
// The sum of these numbers is 1634 + 8208 + 9474 = 19316.
//
// Find the sum of all the numbers that can be written as the sum of
// fifth powers of their digits.
//
//////////////////////////////////////////////////////////////////////
// 443839

package pr030

import "fmt"

func Run() {
	fmt.Printf("%d\n", count_summable(5))
}

func count_summable(power int) (sum int) {
	largest := largest_number(power)
	for i := 2; i <= largest; i++ {
		if digit_power_sum(i, power) == i {
			sum += i
		}
	}
	return
}

func expt(base int, power int) (result int) {
	result = 1
	for power > 0 {
		if (power & 1) != 0 {
			result *= base
		}
		base *= base
		power >>= 1
	}
	return
}

func digit_power_sum(number int, power int) (result int) {
	for number > 0 {
		result += expt(number%10, power)
		number /= 10
	}
	return
}

// Find the largest number possible for a given power.
func largest_number(power int) int {
	num := 9
	for {
		sum := digit_power_sum(num, power)
		if num > sum {
			return sum
		}
		num = num*10 + 9
	}
	panic("Not reached")
}
