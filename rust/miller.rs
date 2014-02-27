// The Miller/Rabin prime sieve.

// It would be more efficient to use bit operations when those are
// available, but that isn't the case for BigInt, so just do things
// with division and modulus, even though this is fairly inefficient
// when just down with '2'.

use std::num::{One,Zero};
use std::rand;

type T = uint;

/// Miller/Rabin primailty test.  Determines if 'n' is prime.  If it
/// returns true, 'n' is prime with a probabily of approximately
/// 1/4**k.
pub fn is_prime(n: T, k: uint) -> bool {
    if n == 1 || n == 0 {
        return false;
    }

    if n == 2 || n == 3 || n == 5 || n == 7 {
        return true;
    }

    if n%2 == 0 || n%2 == 0 || n%5 == 0 || n%7 == 0 {
        return false;
    }

    check(n, k)
}

fn check(n: T, k: uint) -> bool {
    let (s, d) = compute_sd(n);
    for _ in range(0, k) {
        if !round(n, s, d) {
            return false;
        }
    }

    return true;
}

fn round(n: T, s: T, d: T) -> bool {
    let a = rand::random::<T>() % (n - 3) + 2;
    // let a: T = self.rng.gen() % (n - 3) + 2;
    let mut x = exp_mod(a, d, n);

    if x == 1 || x == n-1 {
        return true;
    }

    for _ in range(1, s) {
        x = (x * x) % n;
        if x == 1 {
            return false;
        }

        if x == n-1 {
            return true;
        }
    }

    return false;
}

fn compute_sd(number: T) -> (T, T) {
    let mut s: T = Zero::zero();
    let mut d = number - One::one();
    let one: T = One::one();
    let two = one + one;

    while (d & One::one()) == Zero::zero() {
        s = s + One::one();
        d = d / two;
    }

    (s, d)
}

pub fn exp_mod(base: T, power: T, modulus: T) -> T {
    let mut p = power;
    let mut b = base;
    let mut result: T = One::one();
    let two = result + result;

    while p > Zero::zero() {
        if (p & One::one()) != Zero::zero() {
            result = (result * b) % modulus;
        }

        b = (b * b) % modulus;
        p = p / two;
    }

    result
}

#[cfg(test)]
mod test {
    // use super::*;

    #[test]
    fn test_exp_mod() {
        assert_eq!(super::exp_mod(12345, 54321, 65211), 59112);
    }

    #[test]
    fn test_mr() {
        assert!(!is_prime(655321, 20))
        assert!(!is_prime(655323, 20))
        assert!(is_prime(655331, 20))
    }
}
