/*
 * Problem 32
 *
 * 06 December 2002
 *
 *
 * We shall say that an n-digit number is pandigital if it makes use of
 * all the digits 1 to n exactly once; for example, the 5-digit number,
 * 15234, is 1 through 5 pandigital.
 *
 * The product 7254 is unusual, as the identity, 39 × 186 = 7254,
 * containing multiplicand, multiplier, and product is 1 through 9
 * pandigital.
 *
 * Find the sum of all products whose multiplicand/multiplier/product
 * identity can be written as a 1 through 9 pandigital.
 *
 * HINT: Some products can be obtained in more than one way so be sure
 * to only include it once in your sum.
 */

import std.conv;
import std.stdio;

import euler.misc;

uint euler32() {
    bool[uint] groups;
    auto digits = to!(char[])("123456789");
    do {
	foreach (g; makeGroupings(digits))
	    groups[g] = true;
	digits = nextPermutation(digits);
    } while (digits);

    uint sum = 0;
    foreach (k, v; groups)
	sum += k;
    return sum;
}

// Return all groupings that can be built out of this group of digits.
uint[] makeGroupings(const char[] digits) {
    uint[] result;
    foreach (i; 1 .. digits.length - 2) {
	foreach (j; i+1 .. digits.length) {
	    auto a = to!uint(digits[0 .. i]);
	    auto b = to!uint(digits[i .. j]);
	    auto c = to!uint(digits[j .. $]);
	    if (a*b == c)
		result ~= c;
	}
    }
    return result;
}

unittest {
    // writeln(makeGroupings(to!(char[])("391867254")));
    // writeln(euler32());
    assert(euler32() == 45228);
}
