// Problem 10
//
// 08 February 2002
//
// The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
//
// Find the sum of all the primes below two million.
//
// 142913828922

struct Pr010: Problem {
    typealias T = Int64
    let number = 10
    let expected: T = 142913828922

    func run() -> Int64 {
        let sieve = Sieve()
        var total: Int64 = 0
        var p = 2
        while p < 2000000 {
            total += Int64(p)
            p = sieve.nextPrime(p)
        }
        return total
    }
}
