/*
 * Problem 42
 *
 * 25 April 2003
 *
 *
 * The n^th term of the sequence of triangle numbers is given by, t[n]
 * = 1/2n(n+1); so the first ten triangle numbers are:
 *
 * 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
 *
 * By converting each letter in a word to a number corresponding to its
 * alphabetical position and adding these values we form a word value.
 * For example, the word value for SKY is 19 + 11 + 25 = 55 = t[10]. If
 * the word value is a triangle number then we shall call the word a
 * triangle word.
 *
 * Using words.txt (right click and 'Save Link/Target As...'), a 16K
 * text file containing nearly two-thousand common English words, how
 * many are triangle words?
 */

import std.algorithm;
import std.stdio;

import euler.misc;

ulong euler42() {
    auto fd = File("../haskell/words.txt", "r");
    auto names = fd.readln();
    auto s1 = map!(getName)(splitter(names, ','));

    return count!(isTriangle)(s1);
}

uint getName(string name) {
    name = name[1 .. $-1];
    return reduce!"a+b"(map!"a - 'A' + 1"(name));
}

bool isTriangle(uint num) {
    auto square = num * 8 + 1;
    auto root = isqrt(square);
    return (root * root) == square;
}

debug {
    void main() {
	euler42();
    }
}

unittest {
    assert(euler42() == 162);
}
