/*
 * Problem 37
 *
 * 14 February 2003
 *
 *
 * The number 3797 has an interesting property. Being prime itself, it
 * is possible to continuously remove digits from left to right, and
 * remain prime at each stage: 3797, 797, 97, and 7. Similarly we can
 * work from right to left: 3797, 379, 37, and 3.
 *
 * Find the sum of the only eleven primes that are both truncatable
 * from left to right and right to left.
 *
 * NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
 */

import std.algorithm;
import std.array;
import std.stdio;
import euler.miller_rabin;
import euler.misc;

// Given a list of numbers, return numbers with a single digit
// appended to the right that are still prime.
ulong[] addPrimes(ulong[] numbers) {
    ulong[] result;
    foreach (number; numbers) {
	foreach (extra; [1, 3, 7, 9]) {
	    ulong n = number * 10 + extra;
	    if (mrIsPrime(n))
		result ~= n;
	}
    }
    return result;
}

// Is this number a left truncatable prime.
bool isLeftTruncatable(ulong number) {
    if (number == 0) return true;
    if (!mrIsPrime(number)) return false;
    return isLeftTruncatable(reverseNumber(reverseNumber(number) / 10));
}

// Generate the list of all right truncatable primes.
ulong[] rightTruncatablePrimes() {
    ulong[] result;
    ulong[] set = [2, 3, 5, 7];
    while (set.length > 0) {
	result ~= set;
	// This is kind of cheating, but we have to filter this way.
	if (set[0] < 1000000)
	    set = addPrimes(set);
	else
	    set = [];
    }
    return result;
}

ulong euler37() {
    bool valid(ulong num) {
	return num > 9 && isLeftTruncatable(num);
    }
    return reduce!"a+b"(0UL, filter!(valid)(rightTruncatablePrimes()));
}

unittest {
    assert(euler37() == 748317);
}
