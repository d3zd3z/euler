/*
 * Problem 41
 *
 * 11 April 2003
 *
 *
 * We shall say that an n-digit number is pandigital if it makes use of
 * all the digits 1 to n exactly once. For example, 2143 is a 4-digit
 * pandigital and is also prime.
 *
 * What is the largest n-digit pandigital prime that exists?
 */

/* Since the digits 1-9 sum to 45 and 1-8 sum to 36, indicating that
 * both will always be a multiple of three, we know that the largest
 * pandigital prime can be at most 7 digits.  As long as there is at
 * least on 7 digit pandigital prime, it will be larger than any
 * smaller pandigital primes.
 */

import std.conv;

import euler.misc;
import euler.sieve;

uint euler41() {
    AutoSieve!uint sieve;

    uint largest = 0;
    char[] text = to!(char[])("1234567");
    do {
	auto num = to!uint(text);
	// Numbers are always increasing.
	if (sieve.isPrime(num))
	    largest = num;
	text = nextPermutation(text);
    } while (text);

    return largest;
}

unittest {
    assert(euler41() == 7652413);
}
