// Problem 10
// 
// 08 February 2002
// 
// The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
// 
// Find the sum of all the primes below two million.

use std;

fn main() {
    let primes = sieve::make(2000200u);

    let total = 0u;
    let p = 2u;
    while p < 2_000_000u {
        total += p;
        p = sieve::next_prime(primes, p);
    }

    std::io::println(#fmt("%u", total));
}
