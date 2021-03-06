/**********************************************************************
 * Problem 6
 *
 * 14 December 2001
 *
 *
 * The sum of the squares of the first ten natural numbers is,
 *
 * 1^2 + 2^2 + ... + 10^2 = 385
 *
 * The square of the sum of the first ten natural numbers is,
 *
 * (1 + 2 + ... + 10)^2 = 55^2 = 3025
 *
 * Hence the difference between the sum of the squares of the first ten
 * natural numbers and the square of the sum is 3025 − 385 = 2640.
 *
 * Find the difference between the sum of the squares of the first one
 * hundred natural numbers and the square of the sum.
 **********************************************************************/

import std.stdio;

void main() {
    uint a = 0;
    uint b = 0;
    foreach (n; 1 .. 101) {
	a += n*n;
	b += n;
    }
    auto answer = b*b - a;
    writeln(answer);
}
