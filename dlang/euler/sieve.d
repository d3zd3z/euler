// Prime sieve.

module euler.sieve;
debug(sieve) {
    import std.stdio;
}

class Sieve {
    this(uint limit) {
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

    bool isPrime(uint num) {
	assert (num < _limit);
	return !composite[num];
    }

private:
    bool[] composite;
    uint _limit;
}

struct Factor {
    uint prime;
    uint power;
}

// A sieve that automatically reallocates and recomputes based on the size.
struct AutoSieve {
    bool isPrime(uint num) {
	if (!_sieve || num >= _sieve._limit) {
	    auto newLimit = findLimit(num);
	    debug(sieve)
		writefln("AutoSieve: new size: %d", newLimit);
	    _sieve = new Sieve(newLimit);
	}

	return _sieve.isPrime(num);
    }

    uint nextPrime(uint p) {
	p = (p == 2) ? 3 : p+2;
	while (!isPrime(p))
	    p += 2;
	return p;
    }

    // Return the prime factors of num, with their powers.
    Factor[] factorize(uint num) {
	typeof(return) result;
	uint p = 2;
	uint count = 0;
	while (num > 1) {
	    if (num % p == 0) {
		num /= p;
		++count;
	    } else {
		if (count) {
		    result ~= Factor(p, count);
		    count = 0;
		}
		p = nextPrime(p);
	    }
	}
	if (count) {
	    result ~= Factor(p, count);
	}
	return result;
    }

    // Count the number of divisors of the number.
    uint divisorCount(uint num) {
	uint result = 1;
	foreach (f; factorize(num)) {
	    result *= (f.power + 1);
	}
	return result;
    }

private:
    Sieve _sieve;

    uint findLimit(uint num) {
	// Find the size appropriate for the particular case.
	auto size = 1024;
	while (size <= num)
	    size *= 8;
	return size;
    }
}

unittest {
    import std.stdio;
    AutoSieve s;
    assert(s.factorize(76576500) ==
	   [Factor(2, 2), Factor(3, 2), Factor(5, 3),
	    Factor(7, 1), Factor(11, 1), Factor(13, 1), Factor(17, 1)]);
    assert(s.divisorCount(76576500) == 576);
}
