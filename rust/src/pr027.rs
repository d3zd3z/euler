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

use sieve;
use sieve::Sieve;

define_problem!(main, 27);

fn main() {
    let mut s = Sieve::new();

    let mut max = 0;
    let mut max_product: int = 0;

    for a in range(-999i, 1000) {
        for b in range(-999i, 1000) {
            let count = s.prime_count(a, b);
            if count > max {
                max = count;
                max_product = a * b;
            }
        }
    }
    println!("{}", max_product);
}

trait Counter {
    fn prime_count(&mut self, a: int, b: int) -> uint;
}

impl Counter for sieve::Sieve {
    fn prime_count(&mut self, a: int, b: int) -> uint {
        let mut n = 0;
        loop {
            let p = n*n + a*n + b;
            if p < 2 || !self.is_prime(p as uint) {
                break;
            }
            n += 1;
        }
        n as uint
    }
}
