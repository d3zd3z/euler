/*
 * Problem 48
 *
 * 18 July 2003
 *
 *
 * The series, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.
 *
 * Find the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000
 * ^1000.
 *
 * 9110846700
 */

// BROKEN

import std.stdio;

enum fixedModulus = 10_000_000_000L;

void main() {
    ulong result;

    for (ulong i = 1; i <= 1000; i++) {
	auto tmp = expMod(i, i, fixedModulus);
	result = (result + tmp) % fixedModulus;
    }
    writeln(result);
}

version(none) {
    // This only works where modulus^2 still fits in a 64-bit int, which
    // isn't the case with this problem.
    ulong brokenexpMod(ulong base, ulong power, ulong modulus) {
	ulong result = 1;
	while (power > 0) {
	    if ((power & 1) != 0) {
		result = (result * base) % modulus;
		writefln("multiply: %d", result);
	    }
	    power >>>= 1;
	    writefln("  power: %d", power);
	    base = (base * base) % modulus;
	    writefln("  base: %d", base);
	}

	return result;
    }
}

// Less efficient, but doesn't need numbers larger than base*modulus,
// which do fit in a 64-bit int.
ulong expMod(ulong base, ulong power, ulong modulus) {
    ulong result = 1;
    for (ulong tmp = 0; tmp < power; tmp++) {
	result = (result * base) % modulus;
    }
    return result;
}
