// A basic self-expanding prime sieve.

package euler

import "sort"

type Sieve struct {
	composites []bool
}

func (s *Sieve) IsPrime(n int) bool {
	size := 8192

	if s.composites != nil && len(s.composites) <= n {
		size = len(s.composites)
		s.composites = nil
	}

	if s.composites == nil {
		for size <= n {
			size *= 8
		}
		s.build(size)
	}

	return !s.composites[n]
}

func (s *Sieve) build(size int) {
	comp := make([]bool, size)
	comp[0] = true
	comp[1] = true

	pos := 2
	for pos < size {
		if comp[pos] {
			pos += 2
		} else {
			n := pos + pos
			for n < size {
				comp[n] = true
				n += pos
			}
			if pos == 2 {
				pos += 1
			} else {
				pos += 2
			}
		}
	}
	s.composites = comp
}

func (s *Sieve) NextPrime(base int) (next int) {
	if base == 2 {
		next = 3
	} else {
		next = base + 2
	}

	for !s.IsPrime(next) {
		next += 2
	}

	return
}

type Factor struct {
	Prime int
	Power int
}

func (s *Sieve) Factorize(num int) (factors []Factor) {
	factors = make([]Factor, 0, 5)

	count := 0
	prime := 2
	for num > 1 {
		if (num % prime) == 0 {
			num /= prime
			count++
		} else {
			factors = append(factors, Factor{Prime: prime, Power: count})
			count = 0

			if num > 1 {
				prime = s.NextPrime(prime)
			}
		}
	}
	if count > 0 {
		factors = append(factors, Factor{Prime: prime, Power: count})
	}

	return
}

func (s *Sieve) Divisors(num int) (result []int) {
	result = s.spread(s.Factorize(num))
	sort.Ints(result)
	return
}

func (s *Sieve) spread(factors []Factor) (result []int) {
	if len(factors) == 0 {
		result = []int{1}
		return
	}
	x := factors[0]
	rest := s.spread(factors[1:])
	result = make([]int, 0, 8)
	power := 1
	for i := 0; i <= x.Power; i++ {
		for _, rs := range rest {
			result = append(result, rs*power)
		}
		power *= x.Prime
	}
	return
}

func (s *Sieve) ProperDivisorSum(num int) (result int) {
	divs := s.Divisors(num)
	for _, d := range divs {
		result += d
	}
	result -= num
	return
}
