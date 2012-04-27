/**********************************************************************
 * Problem 10
 *
 * 08 February 2002
 *
 *
 * The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
 *
 * Find the sum of all the primes below two million.
 **********************************************************************/

import std.stdio;
import euler.sieve;

// Fairly simple sieve

void main() {
    AutoSieve!uint sieve;
    ulong sum = 0;
    foreach (x; 2 .. 2_000_000)
	if (sieve.isPrime(x))
	    sum += x;
    writeln(sum);
}
