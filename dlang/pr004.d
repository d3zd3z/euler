/**********************************************************************
 * Problem 4
 *
 * 16 November 2001
 *
 *
 * A palindromic number reads the same both ways. The largest
 * palindrome made from the product of two 2-digit numbers is 9009 = 91
 * × 99.
 *
 * Find the largest palindrome made from the product of two 3-digit
 * numbers.
 **********************************************************************/

import std.stdio;

void main() {
    int largest = -1;
    foreach (a; 100 .. 1000) {
	foreach (b; a .. 1000) {
	    auto tmp = a * b;
	    if (tmp > largest && isPalindrome(tmp))
		largest = tmp;
	}
    }
    writeln(largest);
}

bool isPalindrome(uint number) {
    return number == reverseDigits(number);
}

uint reverseDigits(uint number) {
    uint result = 0;
    while (number > 0) {
	result *= 10;
	result += number % 10;
	number /= 10;
    }
    return result;
}
