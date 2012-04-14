// Problem 3
// 
// 02 November 2001
// 
// The prime factors of 13195 are 5, 7, 13 and 29.
// 
// What is the largest prime factor of the number 600851475143 ?

use std;
import std::bitv;

fn main() {
    let primes = sieve::make(775146u);

    let number = 600851475143u64;
    let prime = 2u;

    while number > 1u64 {
        let p = prime as u64;
        if number % p == 0u64 {
            number /= p;
        } else {
            do {
                prime += 1u;
            } while !sieve::is_prime(primes, prime);
        }
    }

    std::io::println(#fmt("%u", prime));
}
