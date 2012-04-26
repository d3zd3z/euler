/*
 * Problem 17
 *
 * 17 May 2002
 *
 * If the numbers 1 to 5 are written out in words: one, two, three,
 * four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in
 * total.
 *
 * If all the numbers from 1 to 1000 (one thousand) inclusive were
 * written out in words, how many letters would be used?
 *
 *
 * NOTE: Do not count spaces or hyphens. For example, 342 (three
 * hundred and forty-two) contains 23 letters and 115 (one hundred and
 * fifteen) contains 20 letters. The use of "and" when writing out
 * numbers is in compliance with British usage.
 *
 * 21124
 */

import std.stdio;
import std.ascii;

void main() {
    auto count = 0;
    foreach (x; 1 .. 1001) {
	foreach (ch; textify(x))
	    if (isAlpha(ch))
		++count;
    }
    writeln(count);
}

const string[] oneNames = [
  "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
  "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen",
  "seventeen", "eighteen", "nineteen" ];

const string[] tenNames = [
  "ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy",
  "eighty", "ninety" ];

string textify(uint x) in {
    assert(x <= 1000);
} body {
    if (x == 1000) return "one thousand";
    if (x >= 100) {
	auto num = x % 100;
	auto and = num != 0 ? "and " : "";
	return ones(x / 100) ~ " hundred " ~ and ~ textify(num);
    }
    if (x >= 20) {
	auto num = x % 10;
	auto hyphen = num > 0 ? "-" : " ";
	return tens(x / 10) ~ hyphen ~ textify(num);
    }
    if (x >= 1) {
	return ones(x);
    }
    // Zero.
    return "";
}

string ones(uint x) {
    return oneNames[x-1];
}

string tens(uint x) {
    return tenNames[x-1];
}
