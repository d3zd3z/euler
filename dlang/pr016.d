/**********************************************************************
 * Problem 16
 *
 * 03 May 2002
 *
 *
 * 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
 *
 * What is the sum of the digits of the number 2^1000?
 **********************************************************************/

import std.bigint;
import std.stdio;

void main() {
    auto num = BigInt(2) ^^ 1000;
    auto sum = 0;
    while (num > 0) {
	sum += num % 10;
	num /= 10;
    }
    writeln(sum);
}
