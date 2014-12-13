//////////////////////////////////////////////////////////////////////
// Problem 5
// 
// 30 November 2001
// 
// 2520 is the smallest number that can be divided by each of the
// numbers from 1 to 10 without any remainder.
// 
// What is the smallest positive number that is evenly divisible by all
// of the numbers from 1 to 20?
// 
//////////////////////////////////////////////////////////////////////

package pr005

import "fmt"

func Run() {
	answer := 1
	for i := 2; i <= 20; i++ {
		answer = lcm(answer, i)
	}
	fmt.Printf("%d\n", answer)
}

func lcm(a, b int) int {
	return (a / gcd(a, b)) * b
}

// Assumes unsigned.
func gcd(a, b int) int {
	for {
		if b == 0 {
			return a
		}
		a, b = b, a%b
	}
	panic("Unreached")
}
