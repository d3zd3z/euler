/*
 * Problem 30
 *
 * 08 November 2002
 *
 *
 * Surprisingly there are only three numbers that can be written as the
 * sum of fourth powers of their digits:
 *
 *     1634 = 1^4 + 6^4 + 3^4 + 4^4
 *     8208 = 8^4 + 2^4 + 0^4 + 8^4
 *     9474 = 9^4 + 4^4 + 7^4 + 4^4
 *
 * As 1 = 1^4 is not a sum it is not included.
 *
 * The sum of these numbers is 1634 + 8208 + 9474 = 19316.
 *
 * Find the sum of all the numbers that can be written as the sum of
 * fifth powers of their digits.
 */

import std.stdio;

T expt(T)(T base, T power) {
    T result = 1;
    while (power > 0) {
	if ((power & 1) != 0)
	    result *= base;
	base *= base;
	power >>>= 1;
    }
    return result;
}

T digitPowerSum(T)(T number, T power) {
    T result = 0;
    while (number > 0) {
	result += expt (number % 10, power);
	number /= 10;
    }
    return result;
}

// What is the largest number possible for a given power.
T largestNumber(T)(T power) {
    T loop(T num) {
	auto sum = digitPowerSum(num, power);
	if (num > sum)
	    return sum;
	else
	    return loop(num * 10 + 9);
    }
    return loop(9);
}

T countSummable(T)(T power) {
    T sum = 0;
    foreach (i; 2 .. largestNumber(power) + 1) {
	if (digitPowerSum(i, power) == i)
	    sum += i;
    }
    return sum;
}

uint euler30() {
    return countSummable(5u);
}

unittest {
    assert(expt(5, 9) == 1953125);
    assert(digitPowerSum(9474, 4) == 9474);
    assert(euler30() == 443839);
}
