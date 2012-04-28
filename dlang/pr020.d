/*
 * Problem 20
 *
 * 21 June 2002
 *
 *
 * n! means n × (n − 1) × ... × 3 × 2 × 1
 *
 * For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
 * and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0
 * + 0 = 27.
 *
 * Find the sum of the digits in the number 100!
 *
 * 648
 */

import std.bigint;
import euler.misc : digitSum;

uint euler20() {
    auto base = BigInt(1);
    foreach (i; 2 .. 101)
	base *= i;
    return digitSum(base);
}

unittest {
    assert(euler20() == 648);
}
