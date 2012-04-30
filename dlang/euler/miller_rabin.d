/* Miller Rabin primality testing. */

module euler.miller_rabin;
import std.bigint;
import std.random;
import std.stdio;

T expMod(T)(T base, T power, T modulus) {
    T result = 1;
    while (power > 0) {
	if ((power & 1) != 0)
	    result = (result * base) % modulus;
	base = (base * base) % modulus;
	power >>>= 1;
    }
    return result;
}

T computeSD(T)(T n, ref uint s) {
    --n;
    s = 0;
    while ((n & 1) == 0) {
	s++;
	n >>>= 1;
    }
    return n;
}

// TODO: Test this with bigint.
// Returns true if the number might be prime, or false if it is
// definitely not.
bool mrRound(T)(T n, uint s, T d)
{
    auto a = uniform(cast(T) 2, n-1);
    auto x = expMod!T(a, d, n);
    if (x == 1 || x == n-1)
	return true;
    foreach (r; 1 .. s) {
	x = (x * x) % n;
	if (x == 1)
	    return false;
	if (x == n-1)
	    return true;
    }
    return false;
}

// Primality test.  If returns true, 'n' is prime with probability
// (1/4)^k.
bool mrCheck(T)(T n, uint k = 20)
{
    uint s;
    auto d = computeSD(n, s);
    import std.stdio;
    foreach (i; 0 .. k) {
	if (!mrRound(n, s, d))
	    return false;
    }
    return true;
}

bool mrIsPrime(T)(T n, uint k = 20) {
    if (n == 1) return false;
    if (n == 2) return true;
    if (n == 3) return true;
    if (n == 5) return true;
    if (n == 7) return true;
    if ((n % 2) == 0) return false;
    if ((n % 3) == 0) return false;
    if ((n % 5) == 0) return false;
    if ((n % 7) == 0) return false;
    return mrCheck(n, k);
}

unittest {
    assert(expMod(75, 81, 191) == 130);
    uint d;
    assert(computeSD(8193, d) == 1);
    assert(d == 13);

    assert(mrCheck(11));
    assert(mrIsPrime(191));
    assert(!mrIsPrime(192));
    assert(mrIsPrime!ulong(191UL));

    // Fails currently
    assert(!mrIsPrime!ulong(7999997));

    // BigInt isn't used in the numeric code, so test it, since we had
    // to do our own random stuff.
    // import std.stdio;
    // writeln(mrIsPrime(BigInt(191)));
}
