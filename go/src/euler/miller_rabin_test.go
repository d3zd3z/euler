package euler_test

import (
	"euler"
	"testing"
)

func TestMR(t *testing.T) {
	var sv euler.Sieve

	limit := 1000000
	if testing.Short() {
		limit = 100000
	}

	for i := 2; i < limit; i++ {
		b := sv.IsPrime(i)
		b2 := euler.IsPrime(i, 20)

		if b != b2 {
			t.Errorf("Mismatch: %d (%v!=%v)", i, b, b2)
		}
	}
}

func BenchmarkMR(b *testing.B) {
	for i := 0; i < b.N; i++ {
		if !euler.IsPrime(131071, 20) {
			b.Errorf("Prime failure: %s", 131071)
		}
	}
}
