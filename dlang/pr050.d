/*
 * Problem 50
 *
 * 15 August 2003
 *
 *
 * The prime 41, can be written as the sum of six consecutive primes:
 *
 * 41 = 2 + 3 + 5 + 7 + 11 + 13
 *
 * This is the longest sum of consecutive primes that adds to a prime
 * below one-hundred.
 *
 * The longest sum of consecutive primes below one-thousand that adds
 * to a prime, contains 21 terms, and is equal to 953.
 *
 * Which prime, below one-million, can be written as the sum of the
 * most consecutive primes?
 *
 * 997651
 */

import std.array;
import std.stdio;

import euler.sieve;

enum limit = 1_000_000;

uint[] primesUpTo(AutoSieve!uint sieve, uint limit) {
    auto result = appender!(uint[])();

    uint p = 2;
    while (p < limit) {
	result.put(p);
	p = sieve.nextPrime(p);
    }

    return result.data;
}

void main() {
    AutoSieve!uint sieve;
    auto values = primesUpTo(sieve, limit);

    uint largest = 0;
    uint largestLen = 0;

    for (auto as = values; as.length > 0; as = as[1..$]) {
	auto a = as[0];
	auto sum = a;
	auto len = 1;

	foreach (b; as[1..$]) {
	    sum += b;
	    len++;
	    if (sum >= limit)
		break;
	    if (len > largestLen && sieve.isPrime(sum)) {
		largest = sum;
		largestLen = len;
	    }
	}
    }

    writeln(largest);
}
