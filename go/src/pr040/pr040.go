//////////////////////////////////////////////////////////////////////
// Problem 40
//
// Published on Friday, 28th March 2003, 06:00 pm; Solved by 33249
//
// An irrational decimal fraction is created by concatenating the
// positive integers:
//
// 0.123456789101112131415161718192021...
//
// It can be seen that the 12^th digit of the fractional part is 1.
//
// If d[n] represents the n^th digit of the fractional part, find the
// value of the following expression.
//
// d[1] x d[10] x d[100] x d[1000] x d[10000] x d[100000] x d[1000000]
//
//////////////////////////////////////////////////////////////////////
// 210

package pr040

import "fmt"

func Run() {
	nums := make(chan int)
	go generate(nums)

	spans := []int{0, 9, 90, 900, 9000, 90000, 900000}
	prod := 1
	for _, sp := range spans {
		for skip := 1; skip < sp; skip++ {
			_ = <-nums
		}
		item := <-nums
		prod *= item
	}
	fmt.Printf("%d\n", prod)
}

func generate(nums chan<- int) {
	for i := 1; true; i++ {
		for _, dig := range digits(i) {
			nums <- dig
		}
	}
}

// Return the digits that make up the number.
func digits(base int) (result []int) {
	result = make([]int, 0)

	for base != 0 {
		result = append(result, base % 10)
		base /= 10
	}

	a := 0
	b := len(result) - 1
	for a < b {
		result[a], result[b] = result[b], result[a]
		a++
		b--
	}

	return
}
