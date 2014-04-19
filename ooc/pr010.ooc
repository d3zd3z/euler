// Problem 10
//
// 08 February 2002
//
//
// The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
//
// Find the sum of all the primes below two million.
//
// 142913828922

import sieve

// This isn't working.
main: func {
    sv := Sieve new()
    total := 0
    p := 2
    while (p < 2_000_000) {
        total += p
        p = sv nextPrime(p)
    }

    "#{total}" println()
}
