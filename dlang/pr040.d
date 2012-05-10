/*
 * Problem 40
 *
 * 28 March 2003
 *
 *
 * An irrational decimal fraction is created by concatenating the
 * positive integers:
 *
 * 0.123456789101112131415161718192021...
 *
 * It can be seen that the 12^th digit of the fractional part is 1.
 *
 * If d[n] represents the n^th digit of the fractional part, find the
 * value of the following expression.
 *
 * d[1] × d[10] × d[100] × d[1000] × d[10000] × d[100000] × d[1000000]
 */

import std.conv;
import std.stdio;

class Tracker {
    private uint product = 1;

    private uint pos = 0;
    static bool[int]interest;

    static this() {
	interest = [ 1: true, 10: true, 100: true, 1000: true, 10_000: true, 100_000: true, 1_000_000: true ];
    }

    void addNumber(uint number) {
	foreach (ch; to!string(number)) {
	    ++pos;
	    if (pos in interest)
		product *= cast(uint)(ch - '0');
	}
    }

    @property bool done() {
	return pos >= 1_000_000;
    }

    @property uint result() {
	return product;
    }
}

uint euler40() {
    auto track = new Tracker;
    for (uint i = 1; !track.done; ++i) {
	track.addNumber(i);
    }
    return track.result;
}

unittest {
    assert(euler40() == 210);
}
