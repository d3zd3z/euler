/**********************************************************************
 * Problem 7
 *
 * 28 December 2001
 *
 *
 * By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we
 * can see that the 6th prime is 13.
 *
 * What is the 10 001st prime number?
 *
 **********************************************************************/

import std.stdio;

// Start with a simple sieve.
uint euler7() {
    auto composite = new bool[125000];

    composite[0] = true;
    composite[1] = true;
    auto p = 2u;
    auto count = 1;
    while (count < 10001) {
	for (auto n = p+p; n < composite.length; n += p)
	    composite[n] = true;
	p = (p == 2) ? 3 : p+2;
	while (p < composite.length && composite[p])
	    p += 2;
	count++;
	assert (p < composite.length);
    }
    return p;
}

void main() {
    writeln(euler7());
}
