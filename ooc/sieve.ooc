// A prime number sieve

import structs/[ArrayList]

Sieve: class {
    primes: ArrayList<Bool>

    init: func () {
        fill(1024)
    }

    prime?: func(n: Int) -> Bool {
        nsize := primes size
        while (nsize <= n)
            nsize *= 8
        if (nsize > primes size)
            fill(nsize)

        return primes[n]
    }

    nextPrime: func(n: Int) -> Int {
        if (n == 2)
            return 3
        n += 2
        while (!prime?(n))
            n += 2
        return n
    }

    fill: func (size: Int) {
        // "Prime gen: #{size}" println()
        primes = ArrayList<Bool> new(size)
        primes add(false)
        primes add(false)
        for (i in 2..size)
            primes add(true)

        pos := 2
        while (pos < size) {
            if (primes[pos]) {
                n := pos + pos
                while (n < size) {
                    primes[n] = false
                    n += pos
                }
                if (pos == 2)
                    pos = 3
                else
                    pos += 2
            } else {
                // Composite, just skip.
                pos += 2
            }
        }
    }
}
