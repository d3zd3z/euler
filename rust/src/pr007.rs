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

// extern mod extra;

use sieve::Sieve;

define_problem!(main, 7);

fn main() {
    let mut primes = Sieve::new();
    let mut prime = 2u;
    let mut count = 1u;

    while count < 10001 {
        prime = primes.next_prime(prime);
        count += 1;
    }

    println!("{}", prime);
}
