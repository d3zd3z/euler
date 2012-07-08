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
    let mut primes = sieve::make();

    let mut number = 600851475143u64;
    let mut prime = 2;

    while number > 1 {
        let p = prime as u64;
        if number % p == 0 {
            number /= p;
        } else {
            loop {
                prime += 1;
                if sieve::is_prime(primes, prime) {
                    break;
                }
            }
        }
    }

    io::println(#fmt("%u", prime));
}
