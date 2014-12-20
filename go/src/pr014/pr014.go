//////////////////////////////////////////////////////////////////////
// Problem 14
//
// 05 April 2002
//
// The following iterative sequence is defined for the set of positive
// integers:
//
// n → n/2 (n is even)
// n → 3n + 1 (n is odd)
//
// Using the rule above and starting with 13, we generate the following
// sequence:
//
// 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
//
// It can be seen that this sequence (starting at 13 and finishing at
// 1) contains 10 terms. Although it has not been proved yet (Collatz
// Problem), it is thought that all starting numbers finish at 1.
//
// Which starting number, under one million, produces the longest
// chain?
//
// NOTE: Once the chain starts the terms are allowed to go above one
// million.
//
//////////////////////////////////////////////////////////////////////
// 837799 (525)

package pr014

import "fmt"

func Run() {
	maximize()
}

// First, basic brute force.  Probably sufficient, if the stack can
// handle it.

func maximize() int64 {
	max := 0
	maxItem := int64(0)
	// var cache Cache

	// The larger the cache, the faster it is.  Even without a
	// cache, it's only around a second on a modern machine, so
	// not that big of a deal.
	// cache.init(10000)

	for x := int64(1); x < 1000000; x++ {
		count := collatz2(x)
		// count := cache.chainLen(x)
		if count > max {
			max = count
			maxItem = x
		}
	}
	fmt.Printf("%d, %d\n", maxItem, max)
	return maxItem
}

func collatz(n int64) int {
	if n == 1 {
		return 1
	}
	if n%2 == 0 {
		return 1 + collatz(n/2)
	} else {
		return 1 + collatz(n*3+1)
	}
	panic("Not reached")
}

// Non-recursive solution.
func collatz2(n int64) (result int) {
	result = 1

	for n != 1 {
		if n%2 == 0 {
			n /= 2
		} else {
			n = n * 3 + 1
		}
		result++
	}
	return
}

//////////////////////////////////////////////////////////////////////
// Memoized solution.
type Cache struct {
	values []int
}

func (p *Cache) init(size int) {
	p.values = make([]int, size)
}

// This scan makes the assumption that there will not ever be cycles.
func (p *Cache) chainLen(n int64) int {
	if n == 1 {
		return 1
	}
	if n < int64(len(p.values)) {
		// Possibly cached.
		n32 := int32(n)
		if p.values[n32] > 0 {
			return p.values[n32]
		}

		var answer int
		if n32%2 == 0 {
			answer = 1 + p.chainLen(n/2)
		} else {
			answer = 1 + p.chainLen(n*3+1)
		}
		p.values[n32] = answer
		return answer
	} else {
		if n%2 == 0 {
			return 1 + p.chainLen(n/2)
		} else {
			return 1 + p.chainLen(n*3+1)
		}
	}
	panic("Not reached")
}
