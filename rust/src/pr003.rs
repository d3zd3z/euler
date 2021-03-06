// Problem 3
//
// 02 November 2001
//
// The prime factors of 13195 are 5, 7, 13 and 29.
//
// What is the largest prime factor of the number 600851475143 ?
//
// 6857

use crate::sieve::Sieve;

define_problem!(pr003, 3, 6857);

fn pr003() -> usize {
    let mut sieve = Sieve::new();

    let mut number = 600851475143u64;
    let mut prime = 2;

    while number > 1 {
        let p = prime as u64;
        if number % p == 0 {
            number /= p;
        } else {
            prime = sieve.next_prime(prime);
        }
    }

    prime
}
