/*
 * Problem 47
 *
 * 04 July 2003
 *
 *
 * The first two consecutive numbers to have two distinct prime factors
 * are:
 *
 * 14 = 2 x 7
 * 15 = 3 x 5
 *
 * The first three consecutive numbers to have three distinct prime
 * factors are:
 *
 * 644 = 2^2 x 7 x 23
 * 645 = 3 x 5 x 43
 * 646 = 2 x 17 x 19.
 *
 * Find the first four consecutive integers to have four distinct
 * primes factors. What is the first of these numbers?
 *
 * 134043
 */

import std.algorithm;
import std.range;
import std.stdio;

import euler.sieve;

void main() {
    AutoSieve!uint sieve;
    auto factorize(uint a) { return sieve.factorize(a); }
    uint[] numbers = [4, 3, 2, 1];
    auto factors = [factorize(4), factorize(3), factorize(2), factorize(1)];
    void shift() {
	auto next = numbers[0] + 1;
	copy(retro(numbers[0..$-1]), retro(numbers[1..$]));
	numbers[0] = next;
	copy(retro(factors[0..$-1]), retro(factors[1..$]));
	factors[0] = factorize(next);
    }

    // Are all of the factors unique?  This test doesn't seem to
    // actually be necessary, in this case, but it is described by the
    // problem.
    bool allUnique() {
	bool[Factor!uint] every;

	foreach (Factor!uint[] fs; factors) {
	    foreach (Factor!uint f; fs) {
		every[f] = true;
	    }
	}
	return every.length == 16;
    }

    while (true) {
	if (all!"a.length == 4"(factors)) {
	    writeln(numbers);
	    writeln(factors);
	    if (allUnique())
		break;
	}
	shift();
    }
    writeln(numbers[$-1]);

    // foreach(Factor!uint f; array(map!(factorize)(numbers)))
    // 	writeln(f);
}
