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
