/*
 * Problem 39
 *
 * 14 March 2003
 *
 *
 * If p is the perimeter of a right angle triangle with integral length
 * sides, {a,b,c}, there are exactly three solutions for p = 120.
 *
 * {20,48,52}, {24,45,51}, {30,40,50}
 *
 * For which value of p ≤ 1000, is the number of solutions maximised?
 */

import std.stdio;
import euler.triangle;

uint euler39() {
    uint[uint] buckets;
    void set(Triple triple, uint p) {
	// This seems to work.
	++buckets[p];
    }
    generateTriples(1000, &set);

    uint largest = 0;
    uint largestValue = 0;
    foreach (p, count; buckets) {
	if (count > largest) {
	    largest = count;
	    largestValue = p;
	}
    }
    return largestValue;
}

unittest {
    assert(euler39() == 840);
}
