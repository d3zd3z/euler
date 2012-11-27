// A basic self-expanding prime sieve.

package euler

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
