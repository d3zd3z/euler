/*
 * Problem 38
 *
 * 28 February 2003
 *
 *
 * Take the number 192 and multiply it by each of 1, 2, and 3:
 *
 *     192 × 1 = 192
 *     192 × 2 = 384
 *     192 × 3 = 576
 *
 * By concatenating each product we get the 1 to 9 pandigital,
 * 192384576. We will call 192384576 the concatenated product of 192
 * and (1,2,3)
 *
 * The same can be achieved by starting with 9 and multiplying by 1, 2,
 * 3, 4, and 5, giving the pandigital, 918273645, which is the
 * concatenated product of 9 and (1,2,3,4,5).
 *
 * What is the largest 1 to 9 pandigital 9-digit number that can be
 * formed as the concatenated product of an integer with (1,2, ... , n)
 * where n > 1?
 */

import std.stdio;
import euler.misc;

// Use ulong so that the value will always fit.

// Determine if the number isa full 9-element pandigital number.
bool isPandigital(ulong number) {
    uint bits = 0;
    while (number > 0) {
	uint bit = 1 << (number % 10);
	if (bit & bits)
	    return false;
	bits |= bit;
	number /= 10;
    }
    return bits == 1022;  // 1-9 without the zero.
}

// Given a numeric base, return a resulting number by successively
// multiplying by the integers starting with 1.
ulong largeSum(ulong base) {
    ulong loop(uint digits, ulong result, ulong i) {
	if (digits >= 9)
	    return result;
	auto piece = base * i;
	auto pieceDigits = numberOfDigits(piece);
	return loop(digits + pieceDigits,
		result * (10 ^^ pieceDigits) + piece,
		i+1);
    }
    return loop(0, 0, 1);
}

ulong euler38() {
    ulong largest = 0;
    foreach (ulong a; 1 .. 10000) {
	auto sum = largeSum(a);
	if (isPandigital(sum) && sum > largest)
	    largest = sum;
    }
    return largest;
}

unittest {
    assert(isPandigital(123456789));
    assert(!isPandigital(1234567895));
    assert(!isPandigital(12356789));
    assert(largeSum(192) == 192384576);
    assert(euler38() == 932718654);
}
