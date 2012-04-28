/*
 * Problem 24
 *
 * 16 August 2002
 *
 *
 * A permutation is an ordered arrangement of objects. For example,
 * 3124 is one possible permutation of the digits 1, 2, 3 and 4. If all
 * of the permutations are listed numerically or alphabetically, we
 * call it lexicographic order. The lexicographic permutations of 0, 1
 * and 2 are:
 *
 * 012   021   102   120   201   210
 *
 * What is the millionth lexicographic permutation of the digits 0, 1,
 * 2, 3, 4, 5, 6, 7, 8 and 9?
 */

import std.conv;
import std.stdio;

import euler.misc;

string euler24() {
    auto base = to!(char[])("0123456789");
    foreach (i; 1 .. 1_000_000)
	base = nextPermutation(base);
    return to!string(base);
}

unittest {
    assert(euler24() == "2783915460");
}
