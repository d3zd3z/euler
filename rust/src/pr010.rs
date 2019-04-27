// Problem 10
//
// 08 February 2002
//
// The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
//
// Find the sum of all the primes below two million.
//
// 142913828922

use crate::sieve::Sieve;

define_problem!(main, 10, 142913828922);

fn main() -> u64 {
    let mut primes = Sieve::new();

    let mut total = 0u64;
    let mut p = 2;
    while p < 2_000_000 {
        total += p as u64;
        p = primes.next_prime(p);
    }

    total
}
