// Problem 7
//
// 28 December 2001
//
// By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
// that the 6th prime is 13.
//
// What is the 10 001st prime number?
//
// 104743

struct Pr007: Problem {
    typealias T = Int
    let number = 7
    let expected = 104743

    func run() -> Int {
        let sieve = Sieve()
        var prime = 2
        var count = 1

        while count < 10001 {
            prime = sieve.nextPrime(prime)
            count += 1
        }

        return prime
    }
}
