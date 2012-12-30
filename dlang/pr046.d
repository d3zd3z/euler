/*
 * Problem 46
 *
 * 20 June 2003
 *
 *
 * It was proposed by Christian Goldbach that every odd composite
 * number can be written as the sum of a prime and twice a square.
 *
 * 9 = 7 + 2x1^2
 * 15 = 7 + 2x2^2
 * 21 = 3 + 2x3^2
 * 25 = 7 + 2x3^2
 * 27 = 19 + 2x2^2
 * 33 = 31 + 2x1^2
 *
 * It turns out that the conjecture was false.
 *
 * What is the smallest odd composite that cannot be written as the sum
 * of a prime and twice a square?
 *
 * 5777
 */

import euler.sieve;

debug {
    import std.stdio;

    void main() {
	writeln(euler46());
    }
}

uint euler46() {
    AutoSieve!uint sieve;

    /* Does this number have a goldbach decomposition. */
    bool goldbachable(uint n) {
	for (uint p = 2; p < n; p = sieve.nextPrime(p)) {
	    for (uint s = 1; ; s++) {
		auto v = p + 2 * s * s;
		if (v == n)
		    return true;
		if (v > n)
		    break;
	    }
	}

	return false;
    }

    for (uint p = 9; ; p += 2) {
	if (sieve.isPrime(p))
	    continue;
	if (!goldbachable(p))
	    return p;
    }
}

unittest {
    assert(euler46() == 5777);
}
