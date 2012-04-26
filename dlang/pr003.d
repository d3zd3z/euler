/**********************************************************************
 * Problem 3
 *
 * 02 November 2001
 *
 *
 * The prime factors of 13195 are 5, 7, 13 and 29.
 *
 * What is the largest prime factor of the number 600851475143 ?
 *
 **********************************************************************/

import std.stdio;

void main()
{
    // First, just do brute force division.
    long base = 600851475143;
    long factor = 2;

    while (base > 1) {
	if (base % factor == 0) {
	    base /= factor;
	} else {
	    if (factor == 2)
		factor = 3;
	    else
		factor += 2;
	}
    }
    writeln(factor);
}
