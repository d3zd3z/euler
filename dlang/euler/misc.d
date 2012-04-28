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
