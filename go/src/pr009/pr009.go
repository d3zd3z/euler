//////////////////////////////////////////////////////////////////////
// Problem 9
// 
// 25 January 2002
// 
// A Pythagorean triplet is a set of three natural numbers, a < b < c,
// for which,
// 
// a^2 + b^2 = c^2
// 
// For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
// 
// There exists exactly one Pythagorean triplet for which a + b + c =
// 1000.
// Find the product abc.
// 
//////////////////////////////////////////////////////////////////////

// This one can easily be brute forced.

package pr009

import (
	"fmt"
)

func Run() {
	for a := 1; a < 998; a++ {
		for b := a + 1; b < 988; b++ {
			c := 1000 - a - b
			if c > b && a*a+b*b == c*c {
				fmt.Printf("%d\n", a*b*c)
			}
		}
	}
}
