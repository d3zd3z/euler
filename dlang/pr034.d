/*
 * Problem 34
 *
 * 03 January 2003
 *
 *
 * 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
 *
 * Find the sum of all numbers which are equal to the sum of the
 * factorial of their digits.
 *
 * Note: as 1! = 1 and 2! = 2 are not sums they are not included.
 */

import std.stdio;

// Generate the factorials.
uint[] makeFacts() {
    auto result = new uint[10];
    result[] = 1;
    foreach (i; 2 .. 10)
	result[i] = result[i-1] * i;
    return result;
}

uint euler34() {
    const facts = makeFacts();
    int total = -3;  // Subtract out 1! and 2!.
    auto lastFact = facts[9];
    void chain(uint number, uint sum) {
	if (number > 0 && number == sum)
	    total += number;
	if (number * 10 <= sum + lastFact) {
	    foreach (i; (number > 0 ? 0 : 1) .. 10) {
		chain(number * 10 + i, sum + facts[i]);
	    }
	}
    }
    chain(0, 0);
    return total;
}

unittest {
    assert(euler34() == 40730);
}
