/*
 * Problem 26
 *
 * 13 September 2002
 *
 *
 * A unit fraction contains 1 in the numerator. The decimal
 * representation of the unit fractions with denominators 2 to 10 are
 * given:
 *
 *     ^1/[2]  =  0.5
 *     ^1/[3]  =  0.(3)
 *     ^1/[4]  =  0.25
 *     ^1/[5]  =  0.2
 *     ^1/[6]  =  0.1(6)
 *     ^1/[7]  =  0.(142857)
 *     ^1/[8]  =  0.125
 *     ^1/[9]  =  0.(1)
 *     ^1/[10] =  0.1
 *
 * Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle.
 * It can be seen that ^1/[7] has a 6-digit recurring cycle.
 *
 * Find the value of d < 1000 for which ^1/[d] contains the longest
 * recurring cycle in its decimal fraction part.
 */

import std.bigint;

import euler.sieve;

// Solve 10^k for 1 (mod n).
// Should only be called for n >= 7.
uint dlog(uint n) {
    for (uint k = 1; ; ++k) {
	if ((BigInt(10) ^^ k) % n == 1)
	    return k;
    }
}

unittest {
    assert(dlog(987) == 138);
    assert(dlog(983) == 982);
}

uint euler26() {
    AutoSieve!uint sieve;

    auto longest = uint.min;
    uint index = 0;
    for (uint d = 7; d < 1000; d = sieve.nextPrime(d)) {
	auto length = dlog(d);
	if (length > longest) {
	    longest = length;
	    index = d;
	}
    }
    return index;
}

unittest {
    assert(euler26() == 983);
}
