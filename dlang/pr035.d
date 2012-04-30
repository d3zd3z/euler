/*
 * Problem 35
 *
 * 17 January 2003
 *
 *
 * The number, 197, is called a circular prime because all rotations of
 * the digits: 197, 971, and 719, are themselves prime.
 *
 * There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17,
 * 31, 37, 71, 73, 79, and 97.
 *
 * How many circular primes are there below one million?
 */

import std.algorithm;
import std.array;
import std.stdio;
import euler.sieve;

uint numberOfDigits(uint num) {
    uint count = 0;
    while (num > 0) {
	++count;
	num /= 10;
    }
    return count;
}

uint[] numberRotations(uint num) {
    auto len = numberOfDigits(num);
    auto highestOne = 10 ^^ (len-1);
    uint[] result;
    uint[] loop(uint right, uint left, uint accum, uint n) {
	if (left > highestOne)
	    return result;
	auto nQuotient = n / 10;
	auto nRemainder = n % 10;
	auto newAccum = accum + left * nRemainder;
	auto next = nQuotient + right * newAccum;
	result ~= next;
	return loop(right/10, left*10, newAccum, nQuotient);
    }
    return loop(highestOne, 1, 0, num);
}

uint euler35() {
    AutoSieve!uint sieve;
    uint count = 0;
    for (uint p = 2; p < 1_000_000; p = sieve.nextPrime(p)) {
	if(find!((a) { return !sieve.isPrime(a); })(numberRotations(p)).empty) {
	    ++count;
	}
    }
    return count;
}

unittest {
    assert(numberOfDigits(1234567) == 7);
    assert(numberOfDigits(10000) == 5);
    assert(equal(sort(numberRotations(12345)), [12345, 23451, 34512, 45123, 51234]));
    assert(euler35() == 55);
}
