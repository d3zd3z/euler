/*
 * Problem 23
 *
 * 02 August 2002
 *
 *
 * A perfect number is a number for which the sum of its proper
 * divisors is exactly equal to the number. For example, the sum of the
 * proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means
 * that 28 is a perfect number.
 *
 * A number n is called deficient if the sum of its proper divisors is
 * less than n and it is called abundant if this sum exceeds n.
 *
 * As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the
 * smallest number that can be written as the sum of two abundant
 * numbers is 24. By mathematical analysis, it can be shown that all
 * integers greater than 28123 can be written as the sum of two
 * abundant numbers. However, this upper limit cannot be reduced any
 * further by analysis even though it is known that the greatest number
 * that cannot be expressed as the sum of two abundant numbers is less
 * than this limit.
 *
 * Find the sum of all the positive integers which cannot be written as
 * the sum of two abundant numbers.
 *
 * 4179871
 */

import std.algorithm;
import std.range;

import std.stdio;

class Problem23 {
    uint[] abundants;
    uint limit;

    /* We're computing all of the numbers, so just run a sieve, and
     * add up the divisors instead of factoring everything. */
    this(uint limit = 28124) {
	this.limit = limit;
	auto counts = new uint[limit];
	counts[] = 1;  // Start with 1.
	counts[0] = 0; // To be technically correct.
	counts[1] = 0;

	foreach (base; 2 .. limit) {
	    for (auto n = base + base; n < limit; n += base)
		counts[n] += base;
	}

	foreach (num; 12 .. limit) {
	    if (counts[num] > num)
		abundants ~= num;
	}
    }

    uint answer() {
	auto summable = new bool[limit];

	foreach (i; 0 .. abundants.length) {
	    foreach (j; i .. abundants.length) {
		auto num = abundants[i] + abundants[j];
		if (num >= limit)
		    break;
		summable[num] = true;
	    }
	}

	auto sum = 0;
	foreach (i, able; summable) {
	    if (i > 0 && !able)
		sum += i;
	}
	return sum;
    }

    this() { this(28124); }
}

unittest {
    import std.stdio;
    auto p = new Problem23();
    assert(p.answer() == 4179871);
}
