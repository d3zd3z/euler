// Miller rabin primality testing.

package euler

import (
	"math/rand"
)

func IsPrime(num int, k int) bool {
	if num == 1 || num == 0 {
		return false
	}

	if num == 2 || num == 3 || num == 5 || num == 7 {
		return true
	}

	if num%2 == 0 || num%3 == 0 || num%5 == 0 || num%7 == 0 {
		return false
	}

	return check(num, k)
}

// The primality check itself, but doesn't work with small numbers.
func check(num int, k int) bool {
	s, d := compute_sd(num)

	for i := 0; i < k; i++ {
		if !round(num, s, d) {
			return false
		}
	}

	return true
}

func compute_sd(num int) (s, d int) {
	s = 0
	d = num - 1
	for (d & 1) == 0 {
		s += 1
		d >>= 1
	}
	return
}

func round(n, s, d int) bool {
	a := rand.Intn(n-3) + 2
	x := exp_mod(a, d, n)

	if x == 1 || x == n-1 {
		return true
	}

	for r := 0; r < s-1; r++ {
		x = (x * x) % n
		if x == 1 {
			return false
		}

		if x == n-1 {
			return true
		}
	}

	return false
}

func exp_mod(b, p, m int) (result int) {
	result = 1

	for p > 0 {
		if (p & 1) != 0 {
			result = (result * b) % m
		}

		b = (b * b) % m
		p >>= 1
	}

	return
}
