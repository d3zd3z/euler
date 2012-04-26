/* Triangle utilities. */

module euler.triangle;
import std.algorithm;

uint maxTrianglePath(uint[][] src) {
    auto data = src.dup;
    reverse(data);

    while (data.length > 1) {
	data[1] = maxPath(data[0], data[1]);
	data = data[1 .. $];
    }
    assert(data.length == 1);
    assert(data[0].length == 1);
    return data[0][0];
}

// Given two arrays, the first having a length 1 greater than the
// second, find the maximal path.
private uint[] maxPath(uint[] a, uint[] b) in {
    assert(a.length == b.length + 1);
} body {
    auto result = new uint[b.length];
    foreach (pos; 0 .. b.length) {
	auto tmp = b[pos];
	result[pos] = max(a[pos] + tmp, a[pos+1] + tmp);
    }
    return result;
}

