// Problem 7
//
// 28 December 2001
//
//
// By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
// that the 6th prime is 13.
//
// What is the 10 001st prime number?

import sieve

main: func() {
    sv := Sieve new()
    p := 2
    for (i in 1 .. 10001)
        p = sv nextPrime(p)
    "#{p}" println()
}
