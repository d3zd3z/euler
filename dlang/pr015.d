/**********************************************************************
 * Problem 15
 *
 * 19 April 2002
 *
 *
 * Starting in the top left corner of a 2×2 grid, there are 6 routes
 * (without backtracking) to the bottom right corner.
 *
 * [p_015]
 *
 * How many routes are there through a 20×20 grid?
 * 137846528820
 **********************************************************************/

import std.stdio;

void main() {
    writeln(routes(20));
}

ulong routes(uint n) {
    auto vec = base(n);
    foreach (i; 0 .. n)
	bump(vec);
    return vec[$-1];
}

ulong[] base(uint len) {
    auto result = new ulong[len+1];
    result[] = 1;
    return result;
}

void bump(ulong[] vec) {
    foreach (i; 1 .. vec.length) {
	vec[i] = vec[i] + vec[i-1];
    }
}
