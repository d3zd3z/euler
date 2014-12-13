//////////////////////////////////////////////////////////////////////
// Problem 39
//
// Published on Friday, 14th March 2003, 06:00 pm; Solved by 29396
//
// If p is the perimeter of a right angle triangle with integral length
// sides, {a,b,c}, there are exactly three solutions for p = 120.
//
// {20,48,52}, {24,45,51}, {30,40,50}
//
// For which value of p ≤ 1000, is the number of solutions maximised?
//
//////////////////////////////////////////////////////////////////////
// 840

package pr039

import (
	"fmt"

	"euler"
)

func Run() {
	sizes := make(map[int]int)

	for _, trip := range euler.AllTriples(1000) {
		sizes[trip.Circumference]++
	}

	largest := 0
	largestValue := 0

	for k, v := range sizes {
		if v > largestValue {
			largest = k
			largestValue = v
		}
	}

	fmt.Printf("%d\n", largest)
}
