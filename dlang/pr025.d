/*
 * Problem 25
 *
 * 30 August 2002
 *
 *
 * The Fibonacci sequence is defined by the recurrence relation:
 *
 *     F[n] = F[n−1] + F[n−2], where F[1] = 1 and F[2] = 1.
 *
 * Hence the first 12 terms will be:
 *
 *     F[1] = 1
 *     F[2] = 1
 *     F[3] = 2
 *     F[4] = 3
 *     F[5] = 5
 *     F[6] = 8
 *     F[7] = 13
 *     F[8] = 21
 *     F[9] = 34
 *     F[10] = 55
 *     F[11] = 89
 *     F[12] = 144
 *
 * The 12th term, F[12], is the first term to contain three digits.
 *
 * What is the first term in the Fibonacci sequence to contain 1000
 * digits?
 */

import std.bigint;
import std.stdio;

uint euler25() {
    auto limit = BigInt(10) ^^ 999;

    uint count = 1;
    auto a = BigInt(1);
    auto b = a;
    while (a < limit) {
	++count;
	auto tmp = b;
	b += a;
	a = tmp;
    }
    return count;
}

unittest {
    writeln(euler25());
}
