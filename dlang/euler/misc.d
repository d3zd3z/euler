// General things for Project euler problems.

module euler.misc;

import std.algorithm;

// TODO: Put constraints to make better errors.
int digitSum(T)(T num) {
    auto sum = 0;
    while (num > 0) {
	sum += num % 10;
	num /= 10;
    }
    return sum;
}

// Modify the array in place, to generate the next lexical
// permutation.  Returns null if given the last permutation.
// TODO: This doesn't work with gdc.
T[] nextPermutation(T)(T[] text) {
    const int length = cast(int)(text.length);
    int k = -1;
    foreach (int x; 0 .. length - 1) {
	if (text[x] < text[x+1])
	    k = x;
    }
    if (k < 0) return null;
    auto l = -1;
    foreach (x; k+1 .. length) {
	if (text[k] < text[x])
	    l = x;
    }
    swap(text[k], text[l]);
    reverse(text[k + 1 .. $]);
    return text;
}

unittest {
    import std.conv;
    import std.stdio;

    auto a = to!(char[])("012");
    a = nextPermutation(a);
    assert(equal(a, "021"));
    a = nextPermutation(a);
    assert(equal(a, "102"));
    a = nextPermutation(a);
    assert(equal(a, "120"));
    a = nextPermutation(a);
    assert(equal(a, "201"));
    a = nextPermutation(a);
    assert(equal(a, "210"));
    a = nextPermutation(a);
    assert(a is null);
}

// Reverse the digits in the given number for the given base.
T reverseNumber(T)(T number, uint base = 10) {
    T result = 0;
    while (number > 0) {
	result = result * base + number % base;
	number /= base;
    }
    return result;
}

unittest {
    assert(reverseNumber(1234567) == 7654321);
    assert(reverseNumber(585, 2) == 585);
}

// How many digits are in the given number.
uint numberOfDigits(T)(T num) {
    uint count = 0;
    while (num > 0) {
	++count;
	num /= 10;
    }
    return count;
}

unittest {
    assert(numberOfDigits(12345) == 5);
    assert(numberOfDigits(100000) == 6);
}
