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

// Right triangle generator.
struct Box {
    uint p1, p2, q1, q2;
}

const initialBox = Box(1, 1, 2, 3);

// Each box has three children boxes.
private Box[] children(Box box) {
    auto x = box.p2;
    auto y = box.q2;
    return [ Box(y-x, x, y, (y*2 - x)),
	   Box(x, y, (x+y), (x*2 + y)),
	   Box(y, x, (y+x), (y*2 + x)) ];
}

struct Triple {
    uint a, b, c;
}

private uint circumference(Triple triangle) {
    return triangle.a + triangle.b + triangle.c;
}

// Return the three sides of the pythagorean triple described by the
// given box.
private Triple boxTriangle(Box box) {
    return Triple(box.q1 * box.p1 * 2,
	    box.q2 * box.p2,
	    box.p1 * box.q2 + box.p2 * box.q1);
}

private Triple multiplyTriple(Triple tri, uint k) {
    return Triple(tri.a * k, tri.b * k, tri.c * k);
}

// Generate all of the primitive Pythagorean triples with a
// circumference <= limit.  Calls act(triple, circumference) for each
// possible triple.
private void generateFibonacciTriples(uint limit, void delegate(Triple, uint) act) {
    auto work = [initialBox];
    while (work.length > 0) {
	auto box = work[0];
	auto nextWork = work[1 .. $];
	auto triple = boxTriangle(box);
	auto size = circumference(triple);
	if (size <= limit) {
	    nextWork ~= children(box);
	    act(triple, size);
	}
	work = nextWork;
    }
}

void generateTriples(uint limit, void delegate(Triple, uint) act) {
    void subGenerate(Triple triple, uint size) {
	for (uint k = 1; ; ++k) {
	    auto kTriple = multiplyTriple(triple, k);
	    auto kSize = circumference(kTriple);
	    if (kSize > limit)
		break;
	    act(kTriple, kSize);
	}
    }
    generateFibonacciTriples(limit, &subGenerate);
}

// unittest {
//     import std.stdio;
//     void show(Triple t, uint size) {
// 	writeln(t);
//     }
//     generateTriples(50, &show);
// }
