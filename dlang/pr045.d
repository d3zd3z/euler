/*
 * Problem 45
 *
 * 06 June 2003
 *
 *
 * Triangle, pentagonal, and hexagonal numbers are generated by the
 * following formulae:
 *
 * Triangle     T[n]=n(n+1)/2    1, 3, 6, 10, 15, ...
 * Pentagonal   P[n]=n(3n−1)/2   1, 5, 12, 22, 35, ...
 * Hexagonal    H[n]=n(2n−1)     1, 6, 15, 28, 45, ...
 *
 * It can be verified that T[285] = P[165] = H[143] = 40755.
 *
 * Find the next triangle number that is also pentagonal and hexagonal.
 *
 * 1533776805
 */

/*
 * All hexagonal numbers are triangle numbers, so there's no need to
 * check for triangle numbers.
 * To get the nth pentagonal number P(n-1) + (3n-2)
 * To get the nth hexagonal number H(n-1) + (4n-3)
 *
 * To solve the problem, just track the two numbers, incrementing
 * whichever one is smaller until they are equal (and greater than the
 * number in the problem statement.
 */

uint euler45() {
    auto pn = 1;
    auto hn = 1;
    auto pentagonal = 1;
    auto hexagonal = 1;

    while (pentagonal <= 40755 ||
	   pentagonal != hexagonal)
    {
	if (pentagonal < hexagonal) {
	    pn++;
	    pentagonal += 3*pn -2;
	} else {
	    hn++;
	    hexagonal += 4*hn - 3;
	}
    }

    return pentagonal;
}

debug {
    import std.stdio;

    void main() {
	writeln(euler45());
    }
}

unittest {
    assert(euler45() == 1533776805);
}
