//////////////////////////////////////////////////////////////////////
// Problem 34
//
// Published on Friday, 3rd January 2003, 06:00 pm; Solved by 38416
//
// 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
//
// Find the sum of all numbers which are equal to the sum of the
// factorial of their digits.
//
// Note: as 1! = 1 and 2! = 2 are not sums they are not included.
//
//////////////////////////////////////////////////////////////////////
// 40730

package pr034

import "fmt"

func Run() {
	facts := digitFacts()

	total := -3 // Eliminate 1 and 2 as per definition.
	lastFact := facts[len(facts)-1]

	// Trick to get a recursive closure.
	var chain func(int, int)
	chain = func(number int, factSum int) {
		if number > 0 && number == factSum {
			total += number
		}

		if number*10 <= factSum+lastFact {
			base := 1
			if number > 0 {
				base = 0
			}
			for i := base; i < 10; i++ {
				chain(number*10+i,
					factSum+facts[i])
			}
		}
	}

	chain(0, 0)
	fmt.Printf("%d\n", total)
}

func digitFacts() []int {
	result := make([]int, 10)
	result[0] = 1
	for i := 1; i < 10; i++ {
		result[i] = result[i-1] * i
	}
	return result
}
