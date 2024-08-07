// Problem 12
//
// 08 March 2002
//
//
// The sequence of triangle numbers is generated by adding the natural
// numbers. So the 7^th triangle number would be 1 + 2 + 3 + 4 + 5 + 6 + 7 =
// 28. The first ten terms would be:
//
// 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
//
// Let us list the factors of the first seven triangle numbers:
//
//      1: 1
//      3: 1,3
//      6: 1,2,3,6
//     10: 1,2,5,10
//     15: 1,3,5,15
//     21: 1,3,7,21
//     28: 1,2,4,7,14,28
//
// We can see that 28 is the first triangle number to have over five
// divisors.
//
// What is the value of the first triangle number to have over five hundred
// divisors?
//
// 76576500

class Pr012: Problem {
    typealias T = Int
    let number = 12
    let expected = 76576500

    let sieve = Sieve()

    func run() -> Int {
        for tri in TriGenerator() {
            let dcount = divisorCount(tri)
            // print(tri, dcount)
            if dcount > 500 {
                return tri
            }
        }
        fatalError("Unreachable")
    }

    func divisorCount(_ n: Int) -> Int {
        var result = 1
        var tmp = n
        var prime = 2

        while tmp > 1 {
            var divideCount = 0
            while tmp % prime == 0 {
                tmp /= prime
                divideCount += 1
            }

            result *= divideCount + 1

            if tmp > 1 {
                prime = sieve.nextPrime(prime)
            }
        }

        return result
    }
}

// Generate all of the triangle numbers.
public struct TriGenerator: IteratorProtocol, Sequence {
    public typealias T = Int

    public mutating func next() -> Int? {
        let result = tri

        n += 1
        tri += n
        return result
    }

    var n = 1
    var tri = 1
}
