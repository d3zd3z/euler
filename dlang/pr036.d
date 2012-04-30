/*
 * Problem 36
 *
 * 31 January 2003
 *
 *
 * The decimal number, 585 = 1001001001[2] (binary), is palindromic in
 * both bases.
 *
 * Find the sum of all numbers, less than one million, which are
 * palindromic in base 10 and base 2.
 *
 * (Please note that the palindromic number, in either base, may not
 * include leading zeros.)
 */

import std.stdio;
import euler.misc;

uint euler36() {
    uint sum = 0;
    foreach (uint number; 1 .. 1_000_000) {
	if (isPalindrome(number, 10) && isPalindrome(number, 2))
	    sum += number;
    }
    return sum;
}

bool isPalindrome(T)(T number, uint base = 10) {
    return number == reverseNumber(number, base);
}

unittest {
    assert(euler36() == 872187);
}
