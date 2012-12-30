/*
 * Problem 44
 *
 * 23 May 2003
 *
 *
 * Pentagonal numbers are generated by the formula, P[n]=n(3n−1)/2. The
 * first ten pentagonal numbers are:
 *
 * 1, 5, 12, 22, 35, 51, 70, 92, 117, 145, ...
 *
 * It can be seen that P[4] + P[7] = 22 + 70 = 92 = P[8]. However,
 * their difference, 70 − 22 = 48, is not pentagonal.
 *
 * Find the pair of pentagonal numbers, P[j] and P[k], for which their
 * sum and difference is pentagonal and D = |P[k] − P[j]| is minimised;
 * what is the value of D?
 *
 * 5482660
 */

import euler.misc;
debug {
    import std.stdio;
}

uint euler44() {
    for (int i = 2; true; i++) {
	auto pentI = nthPentagonal(i);
	for (int j = 1; j <= i; j++) {
	    auto pentJ = nthPentagonal(j);

	    if (isPentagonal(pentI - pentJ) &&
		isPentagonal(pentI + pentJ))
	    {
		return pentI - pentJ;
	    }
	}
    }
}

uint nthPentagonal(uint n) {
    return n * (3 * n - 1) / 2;
}

bool isPentagonal(uint n) {
    auto square = n * 24 + 1;
    auto root = isqrt(square);
    return (root * root == square) && ((root + 1) % 6 == 0);
}

debug {
    void main() {
	writeln(euler44());
    }
}

unittest {
    assert(euler44() == 5482660);
}
