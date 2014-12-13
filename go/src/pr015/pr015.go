//////////////////////////////////////////////////////////////////////
// Problem 15
// 
// 19 April 2002
// 
// Starting in the top left corner of a 2x2 grid, there are 6 routes
// (without backtracking) to the bottom right corner.
// 
// [p_015]
// 
// How many routes are there through a 20x20 grid?
// 
//////////////////////////////////////////////////////////////////////
// 137846528820

package pr015

import "fmt"

const steps int = 20

func Run() {
	values := make([]int64, steps+1)
	fill(values)

	for i := 0; i < steps; i++ {
		bump(values)
	}
	fmt.Printf("%d\n", values[steps])
}

func fill(values []int64) {
	for x := 0; x < len(values); x++ {
		values[x] = 1
	}
}

func bump(values []int64) {
	for x := 0; x < steps; x++ {
		values[x+1] += values[x]
	}
}
