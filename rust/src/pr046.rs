// Problem 46
//
// 20 June 2003
//
//
// It was proposed by Christian Goldbach that every odd composite number can
// be written as the sum of a prime and twice a square.
//
// 9 = 7 + 2x1^2
// 15 = 7 + 2x2^2
// 21 = 3 + 2x3^2
// 25 = 7 + 2x3^2
// 27 = 19 + 2x2^2
// 33 = 31 + 2x1^2
//
// It turns out that the conjecture was false.
//
// What is the smallest odd composite that cannot be written as the sum of a
// prime and twice a square?

use crate::misc;
use crate::sieve::Sieve;

define_problem!(pr046, 46, 5777);

fn pr046() -> usize {
    let mut primes = Sieve::new();

    for n in (0..).map(|x| 2*x+9) {
        if primes.is_prime(n) {
            continue;
        }
        if let None = primes.goldbach(n) {
            return n;
        }
    }
    unreachable!();
}

trait Gold {
    //  Return the first goldbach prime for the given number, if present.
    fn goldbach(&mut self, n: usize) -> Option<usize>;
}

impl Gold for Sieve {
    fn goldbach(&mut self, n: usize) -> Option<usize> {
        for p in self.primes_upto(n) {
            if p == 2 {
                continue;
            }
            if perfect_root((n - p) / 2) {
                return Some(p)
            }
        }
        None
    }
}

fn perfect_root(base: usize) -> bool {
    let root = misc::isqrt(base);
    root * root == base
}
