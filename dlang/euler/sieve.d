// Prime sieve.

module euler.sieve;
import std.traits;
debug(sieve) {
    import std.stdio;
}

class Sieve(T) {
    this(T limit) {
	_limit = limit;
	composite = new bool[limit];
	composite[0] = true;
	composite[1] = true;
	auto p = 2u;
	while (p < limit) {
	    for (auto n = p+p; n < limit; n += p)
		composite[n] = true;
	    p = (p == 2) ? 3 : p+2;
	    while (p < limit && composite[p])
		p += 2;
	}
    }

    bool isPrime(T num) {
	assert (num < _limit);
	return !composite[num];
    }

private:
    bool[] composite;
    T _limit;
}

struct Factor(T)
// It'd be nice if this was helpful, but the error doesn't show up in
// the use, but here.
    if (is(typeof(T.init == 0) == bool))
{
    T prime;
    T power;
}

// A sieve that automatically reallocates and recomputes based on the size.
struct AutoSieve(T) {
    bool isPrime(T num) {
	if (!_sieve || num >= _sieve._limit) {
	    auto newLimit = findLimit(num);
	    debug(sieve)
		writefln("AutoSieve: new size: %d", newLimit);
	    _sieve = new Sieve!T(newLimit);
	}

	return _sieve.isPrime(num);
    }

    T nextPrime(T p) {
	p = (p == 2) ? 3 : p+2;
	while (!isPrime(p))
	    p += 2;
	return p;
    }

    // Return the prime factors of num, with their powers.
    Factor!T[] factorize(T num) {
	typeof(return) result;
	T p = 2;
	T count = 0;
	while (num > 1) {
	    if (num % p == 0) {
		num /= p;
		++count;
	    } else {
		if (count) {
		    result ~= Factor!T(p, count);
		    count = 0;
		}
		p = nextPrime(p);
	    }
	}
	if (count) {
	    result ~= Factor!T(p, count);
	}
	return result;
    }

    // Count the number of divisors of the number.
    T divisorCount(T num) {
	T result = 1;
	foreach (f; factorize(num)) {
	    result *= (f.power + 1);
	}
	return result;
    }

private:
    Sieve!T _sieve;

    T findLimit(T num) {
	// Find the size appropriate for the particular case.
	auto size = 1024;
	while (size <= num)
	    size *= 8;
	return size;
    }
}

unittest {
    alias Factor!uint F;
    import std.stdio;
    AutoSieve!uint s;
    assert(s.factorize(76576500) ==
	   [F(2, 2), F(3, 2), F(5, 3),
	    F(7, 1), F(11, 1), F(13, 1), F(17, 1)]);
    assert(s.divisorCount(76576500) == 576);
}
