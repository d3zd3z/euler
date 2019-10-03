// Prime sieve, optimized for searching for small primes.

package org.davidb.euler

val defaultSize = 8192

class Sieve: Iterable<Int> {
    private var vec: Array<Boolean> = Array<Boolean>(defaultSize, { true })
    init {
        fill()
    }

    fun isPrime(n: Int): Boolean {
        if (n >= vec.size) {
            var newLimit = vec.size
            while (newLimit <= n) {
                newLimit *= 8
            }

            vec = Array<Boolean>(newLimit, { true })
            fill()
        }

        return vec[n]
    }

    fun nextPrime(n: Int): Int {
        if (n == 2) {
            return 3
        }

        var next = n + 2
        while (!isPrime(next)) {
            next += 2
        }
        return next
    }

    override operator fun iterator(): Iterator<Int> = SieveIterator()

    inner class SieveIterator: Iterator<Int> {
        private var cur = 2
        override operator fun hasNext(): Boolean {
            return true
        }
        override operator fun next(): Int {
            val result = cur
            cur = nextPrime(cur)
            return result
        }
    }

    // When factoring, a Factor represents a factor of the number,
    // along with the power.
    data class Factor(val prime: Int, val power: Int)

    // Straightforward factorization.
    fun factorize(n: Int): ArrayList<Factor> {
        val result = ArrayList<Factor>()

        var tmp = n
        var prime = 2
        var count = 0

        while (tmp > 1) {
            if (tmp % prime == 0) {
                tmp /= prime
                count++
            } else {
                if (count > 0) {
                    result.add(Factor(prime, count))
                    count = 0
                }

                if (tmp > 1) {
                    prime = nextPrime(prime)
                }
            }
        }

        if (count > 0) {
            result.add(Factor(prime, count))
        }

        return result
    }

    // Return all divisors of a given number
    fun divisors(n: Int): ArrayList<Int> {
        val factors = factorize(n)
        val result = ArrayList<Int>()
        spread(factors, result)
        result.sort()
        return result
    }

    private fun fill() {
        vec[0] = false
        vec[1] = false

        // println("fill: ${vec.size}")
        var pos = 2
        val limit = vec.size
        while (pos < limit) {
            if (!vec[pos]) {
                pos += 2
            } else {
                var n = pos + pos
                while (n < limit) {
                    vec[n] = false
                    n += pos
                }
                if (pos == 2) {
                    pos += 1
                } else {
                    pos += 2
                }
            }
        }
    }
}

// Spread out the result of these factors.  The 'start' value is the
// first factor to be considered.
private fun spread(factors: ArrayList<Sieve.Factor>, result: ArrayList<Int>, start: Int = 0) {
    if (start >= factors.size) {
        result.add(1)
    } else {
        val rest = ArrayList<Int>()
        val x = factors[start]
        spread(factors, rest, start + 1)

        var power = 1
        for (i in 0 .. x.power) {
            for (elt in rest) {
                result.add(elt * power)
            }
            if (i < power) {
                power *= x.prime
            }
        }
    }
}
