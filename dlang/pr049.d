/*
 * Problem 49
 *
 * 01 August 2003
 *
 *
 * The arithmetic sequence, 1487, 4817, 8147, in which each of the
 * terms increases by 3330, is unusual in two ways: (i) each of the
 * three terms are prime, and, (ii) each of the 4-digit numbers are
 * permutations of one another.
 *
 * There are no arithmetic sequences made up of three 1-, 2-, or
 * 3-digit primes, exhibiting this property, but there is one other
 * 4-digit increasing sequence.
 *
 * What 12-digit number do you form by concatenating the three terms in
 * this sequence?
 *
 * 296962999629
 */

import std.algorithm;
import std.array;
import std.stdio;

import euler.misc;
import euler.sieve;

uint[] getDigits(uint number) {
    auto result = appender!(uint[])();

    while (number > 0) {
	result.put(number % 10);
	number /= 10;
    }

    auto tmp = result.data;
    reverse(tmp);
    return tmp;
}

uint unDigits(uint[] digits) {
    uint result = 0;
    foreach (d; digits) {
	result = result * 10 + d;
    }
    return result;
}

// Are the digits of this number nondecreasing from left to right.
// This assures we only look at the first number of any given
// permutation.
bool isAscending(uint number) {
    uint last = 10;
    while (number > 0) {
	auto tmp = number % 10;
	if (tmp > last)
	    return false;
	last = tmp;
	number /= 10;
    }
    return true;
}

uint[] primePermutations(AutoSieve!uint sieve, uint number) {
    auto result = appender!(uint[])();
    auto digits = getDigits(number);

    void add() {
	auto tmp = unDigits(digits);
	if (sieve.isPrime(tmp))
	    result.put(tmp);
    }

    add();
    while (nextPermutation(digits) !is null) {
	add();
    }

    return result.data;
}

// Generate all of the partitions of the data.
uint[][] partitions(uint[] base) {
    uint[][] walk(uint[] piece) {
	if (piece.length == 0)
	    return [[]];
	auto rest = walk(piece[1..$]);
	auto hd = piece[0];
	auto append(uint[] elts) {
	    return hd ~ elts;
	}
	auto withHead = array(map!append(rest));
	return rest ~ withHead;
    }

    return walk(base);
}

bool valid(uint[] nums) {
    return (nums.length == 3 &&
	    nums[2] - nums[1] == nums[1] - nums[0]);
}

void main() {
    AutoSieve!uint sieve;

    for (uint num = 1000; num < 10000; num++) {
	if (!isAscending(num))
	    continue;

	// Skip the known case.
	if (num == 1478)
	    continue;

	auto parts = partitions(primePermutations(sieve, num));
	auto small = filter!valid(parts);
	if (!small.empty) {
	    auto first = small.front;
	    writeln(first[0], first[1], first[2]);
	}
    }
}
