// A prime sieve.

public class Sieve {
    var vec: Array<Bool>
    var limit: Int

    init(isize: Int = 8192) {
        limit = isize
        vec = [Bool](count: limit + 1, repeatedValue: true)
        fill()
    }

    public func isPrime(n: Int) -> Bool {
        if n > limit {
            var newLimit = limit
            while newLimit < n {
                newLimit *= 8
            }

            vec = [Bool](count: newLimit + 1, repeatedValue: true)
            limit = newLimit
            fill()
        }

        return vec[n]
    }

    public func nextPrime(n: Int) -> Int {
        if n == 2 {
            return 3;
        }

        var next = n + 2
        while !isPrime(next) {
            next += 2
        }
        return next
    }

    // TODO: Can we make this work as a sequence?
    public func generate(upto upto: Int) -> SieveGenerator {
        return SieveGenerator(sieve: self, upto: upto)
    }

    func fill() {
        vec[0] = false
        vec[1] = false

        var pos = 2
        while pos <= limit {
            if !vec[pos] {
                pos += 2
            } else {
                var n = pos + pos
                while n <= limit {
                    vec[n] = false
                    n += pos
                }
                if pos == 2 {
                    pos += 1
                } else {
                    pos += 2
                }
            }
        }
    }
}

public class SieveGenerator: GeneratorType {
    public typealias Element = Int
    var sieve: Sieve
    var cur: Int
    var limit: Int?

    init(sieve: Sieve, upto: Int) {
        self.sieve = sieve
        cur = 2
        self.limit = 2
    }

    public func next() -> Int? {
        if cur > limit {
            return nil
        }

        let result = cur
        cur = sieve.nextPrime(cur)
        return result
    }
}
