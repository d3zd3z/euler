/*
 * Problem 33
 *
 * 20 December 2002
 *
 *
 * The fraction ^49/[98] is a curious fraction, as an inexperienced
 * mathematician in attempting to simplify it may incorrectly believe
 * that ^49/[98] = ^4/[8], which is correct, is obtained by cancelling
 * the 9s.
 *
 * We shall consider fractions like, ^30/[50] = ^3/[5], to be trivial
 * examples.
 *
 * There are exactly four non-trivial examples of this type of
 * fraction, less than one in value, and containing two digits in the
 * numerator and denominator.
 *
 * If the product of these four fractions is given in its lowest common
 * terms, find the value of the denominator.
 */

import std.stdio;
import std.numeric;

uint euler33() {
    uint prodn = 1;
    uint prodm = 1;

    foreach (a; 10 .. 100)
	foreach (b; a+1 .. 100)
	    if (isFrac(a, b)) {
		prodn *= a;
		prodm *= b;

		auto g = gcd(prodn, prodm);
		if (g > 1) {
		    prodn /= g;
		    prodm /= g;
		}
	    }

    return prodm;
}

bool isFrac(uint a, uint b) {
    auto an = a / 10;
    auto am = a % 10;
    auto bn = b / 10;
    auto bm = b % 10;
    return (an == bm && bn > 0 && am*b == bn*a) ||
	(am == bn && bm > 0 && an*b == bm*a);
}

unittest {
    assert(euler33() == 100);
}
