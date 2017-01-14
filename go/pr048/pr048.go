//////////////////////////////////////////////////////////////////////
// Problem 48
//
// 18 July 2003
//
// The series, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.
//
// Find the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000
// ^1000.
//
// 9110846700
//////////////////////////////////////////////////////////////////////

package pr048

import (
	"fmt"
)

const modulus = 10000000000

func Run() {
	sum := int64(0)
	for i := 1; i <= 1000; i++ {
		sum = (sum + expt(int64(i), i)) % modulus
	}

	fmt.Printf("%d\n", sum)
}

func expt(base int64, power int) (result int64) {
	result = 1
	for i := 0; i < power; i++ {
		result = (result * base) % modulus
	}
	return
}
