/**********************************************************************
 * Problem 5
 *
 * 30 November 2001
 *
 *
 * 2520 is the smallest number that can be divided by each of the
 * numbers from 1 to 10 without any remainder.
 *
 * What is the smallest positive number that is evenly divisible by all
 * of the numbers from 1 to 20?
 **********************************************************************/

import std.stdio;

void main() {
    uint base = 2;
    foreach (n; 3 .. 21)
	base = lcm(base, n);
    writeln(base);
}

uint gcd(uint a, uint b) {
    if (b == 0) return a;
    else return gcd(b, a % b);
}

uint lcm(uint a, uint b) {
    return (a / gcd(a, b)) * b;
}
