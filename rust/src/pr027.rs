// Problem 27
//
// 27 September 2002
//
//
// Euler published the remarkable quadratic formula:
//
// n^2 + n + 41
//
// It turns out that the formula will produce 40 primes for the consecutive
// values n = 0 to 39. However, when n = 40, 40^2 + 40 + 41 = 40(40 + 1) + 41
// is divisible by 41, and certainly when n = 41, 41^2 + 41 + 41 is clearly
// divisible by 41.
//
// Using computers, the incredible formula  n^2 − 79n + 1601 was discovered,
// which produces 80 primes for the consecutive values n = 0 to 79. The
// product of the coefficients, −79 and 1601, is −126479.
//
// Considering quadratics of the form:
//
//     n^2 + an + b, where |a| < 1000 and |b| < 1000
//
//     where |n| is the modulus/absolute value of n
//     e.g. |11| = 11 and |−4| = 4
//
// Find the product of the coefficients, a and b, for the quadratic
// expression that produces the maximum number of primes for consecutive
// values of n, starting with n = 0.
// -59231

use crate::sieve;
use crate::sieve::Sieve;

define_problem!(pr027, 27, -59231);

fn pr027() -> i64 {
    let mut s = Sieve::new();

    let mut max = 0;
    let mut max_product: i64 = 0;

    for a in -999 .. 1000 {
        for b in -999 .. 1000 {
            let count = s.prime_count(a, b);
            if count > max {
                max = count;
                max_product = a * b;
            }
        }
    }
    max_product
}

trait Counter {
    fn prime_count(&mut self, a: i64, b: i64) -> u64;
}

impl Counter for sieve::Sieve {
    fn prime_count(&mut self, a: i64, b: i64) -> u64 {
        let mut n = 0;
        loop {
            let p = n*n + a*n + b;
            if p < 2 || !self.is_prime(p as usize) {
                break;
            }
            n += 1;
        }
        n as u64
    }
}
