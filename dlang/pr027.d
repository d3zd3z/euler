/*
 * Problem 27
 *
 * 27 September 2002
 *
 *
 * Euler published the remarkable quadratic formula:
 *
 * n² + n + 41
 *
 * It turns out that the formula will produce 40 primes for the
 * consecutive values n = 0 to 39. However, when n = 40, 40^2 + 40 + 41
 * = 40(40 + 1) + 41 is divisible by 41, and certainly when n = 41, 41²
 * + 41 + 41 is clearly divisible by 41.
 *
 * Using computers, the incredible formula  n² − 79n + 1601 was
 * discovered, which produces 80 primes for the consecutive values n =
 * 0 to 79. The product of the coefficients, −79 and 1601, is −126479.
 *
 * Considering quadratics of the form:
 *
 *     n² + an + b, where |a| < 1000 and |b| < 1000
 *
 *     where |n| is the modulus/absolute value of n
 *     e.g. |11| = 11 and |−4| = 4
 *
 * Find the product of the coefficients, a and b, for the quadratic
 * expression that produces the maximum number of primes for
 * consecutive values of n, starting with n = 0.
 */

import std.stdio;
import std.bigint;
import euler.sieve;

int euler27() {
    AutoSieve!uint sieve;
    
    int countPrimes(int a, int b) {
	for (int n = 0; ; ++n) {
	    auto p = n*n + a*n + b;
	    if (p <= 0 || !sieve.isPrime(p))
		return n;
	}
    }

    int largest = 0;
    int largestResult = int.min;
    foreach (a; -999 .. 1000) {
	foreach (b; -999 .. 1000) {
	    auto count = countPrimes(a, b);
	    if (count > largest) {
		largest = count;
		largestResult = a * b;
	    }
	}
    }
    return largestResult;
}

unittest {
    assert(euler27() == -59231);
}
