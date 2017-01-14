//////////////////////////////////////////////////////////////////////
// Problem 23
//
// Published on Friday, 2nd August 2002, 06:00 pm; Solved by 37114
//
// A perfect number is a number for which the sum of its proper
// divisors is exactly equal to the number. For example, the sum of the
// proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means
// that 28 is a perfect number.
//
// A number n is called deficient if the sum of its proper divisors is
// less than n and it is called abundant if this sum exceeds n.
//
// As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the
// smallest number that can be written as the sum of two abundant
// numbers is 24. By mathematical analysis, it can be shown that all
// integers greater than 28123 can be written as the sum of two
// abundant numbers. However, this upper limit cannot be reduced any
// further by analysis even though it is known that the greatest number
// that cannot be expressed as the sum of two abundant numbers is less
// than this limit.
//
// Find the sum of all the positive integers which cannot be written as
// the sum of two abundant numbers.
//
//////////////////////////////////////////////////////////////////////
// 4179871

package pr023

import "github.com/d3zd3z/euler/go/euler"
import "fmt"

const limit = 28124

func Run() {
	notAdd := make(map[int]bool)
	abundants := makeAbundants(limit)

	for ai, a := range abundants {
		for bi := ai; bi < len(abundants); bi++ {
			sum := a + abundants[bi]
			if sum < limit {
				notAdd[sum] = true
			}
		}
	}

	total := 0
	for i := 1; i < limit; i++ {
		if !notAdd[i] {
			total += i
		}
	}

	fmt.Printf("%d\n", total)
}

// We are computing all of the divisors, it is much faster to use a
// modified sieve, and compute the divisors as we go.
func makeDivisors(limit int) (result []int) {
	result = make([]int, limit)

	for i := range result {
		result[i] = 1
	}

	for i := 2; i < limit; i++ {
		n := i + i
		for n < limit {
			result[n] += i
			n += i
		}
	}

	return
}

func makeAbundants(limit int) (result []int) {
	divisors := makeDivisors(limit)
	result = make([]int, 0)
	for i := 1; i < len(divisors); i++ {
		if i < divisors[i] {
			result = append(result, i)
		}
	}

	return
}

func mainSlow() {
	var sieve euler.Sieve

	abundants := make([]int, 0, 7000)
	abundantSet := make(map[int]bool, 7000)

	for i := 12; i < limit; i++ {
		if isAbundant(&sieve, i) {
			abundants = append(abundants, i)
			abundantSet[i] = true
		}
	}

	sum := 0
	for i := 1; i < limit; i++ {
		hit := true
		for _, ab := range abundants {
			if abundantSet[i-ab] {
				hit = false
				break
			}
		}
		if hit {
			sum += i
		}
	}

	fmt.Printf("%d\n", sum)
}

func isAbundant(s *euler.Sieve, n int) bool {
	return s.ProperDivisorSum(n) > n
}
