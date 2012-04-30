/*
 * Problem 31
 *
 * 22 November 2002
 *
 *
 * In England the currency is made up of pound, £, and pence, p, and
 * there are eight coins in general circulation:
 *
 *     1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
 *
 * It is possible to make £2 in the following way:
 *
 *     1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
 *
 * How many different ways can £2 be made using any number of coins?
 */

import std.stdio;

// This problem isn't particularly large, so just brute force is
// sufficient.
const uint[] coins = [200, 100, 50, 20, 10, 5, 2, 1];

uint euler31() {
    return rways(200, coins);
}

uint rways(int remaining, const uint[] coins) {
    if (coins.length == 0)
	return remaining == 0 ? 1 : 0;
    auto coin = coins[0];
    auto others = coins[1 .. $];
    uint loop(uint sum, int remaining) {
	if (remaining >= 0)
	    return loop(sum + rways(remaining, others), remaining - coin);
	else
	    return sum;
    }
    return loop(0, remaining);
}

unittest {
    assert(euler31() == 73682);
}
