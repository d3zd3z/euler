// Problem 14
//
// 05 April 2002
//
//
// The following iterative sequence is defined for the set of positive
// integers:
//
// n → n/2 (n is even)
// n → 3n + 1 (n is odd)
//
// Using the rule above and starting with 13, we generate the following
// sequence:
//
// 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
//
// It can be seen that this sequence (starting at 13 and finishing at 1)
// contains 10 terms. Although it has not been proved yet (Collatz Problem),
// it is thought that all starting numbers finish at 1.
//
// Which starting number, under one million, produces the longest chain?
//
// NOTE: Once the chain starts the terms are allowed to go above one million.
//
// 837799

struct Pr014: Problem {
    typealias T = Int
    let number = 14
    let expected = 837799

    func run() -> Int {
        // var collatz = NonCachedCollatz()
        var collatz = EnumCachedCollatz()

        var maxLen = 0
        var max = 0
        for x in 1 ..< 1000000 {
            let len = collatz.chainLen(x)
            if len > maxLen {
                maxLen = len
                max = x
            }
        }
        // print(maxLen, max)
        return max
    }
}

struct NonCachedCollatz {
    mutating func chainLen(_ n: Int) -> Int {
        var work = n
        var len = 1
        while work > 1 {
            len += 1
            if work & 1 == 0 {
                work >>= 1
            } else {
                work = work * 3 + 1
            }
        }
        return len
    }
}

// The EnumCached version is recursive, which is slower, but cached,
// which speeds it up.
struct EnumCachedCollatz {
    enum Info {
        case Unknown
        case Known(Int)
    }
    let size: Int
    var cache: [Info]
    init() {
        size = 100000
        cache = Array(repeating: Info.Unknown, count: size)
    }

    mutating func chainLen(_ n: Int) -> Int {
        if n < size {
            switch cache[n] {
            case Info.Unknown:
                let answer = chain2(n)
                cache[n] = Info.Known(answer)
                return answer
            case let Info.Known(x):
                return x
            }
        } else {
            return chain2(n)
        }
    }

    mutating func chain2(_ n: Int) -> Int {
        if n == 1 {
            return 1
        } else if n & 1 == 0 {
            return 1 + chainLen(n >> 1)
        } else {
            return 1 + chainLen(3 * n + 1)
        }
    }
}
