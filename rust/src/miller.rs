// The Miller/Rabin prime sieve.

// It would be more efficient to use bit operations when those are
// available, but that isn't the case for BigInt, so just do things
// with division and modulus, even though this is fairly inefficient
// when just down with '2'.

use std::num::Int;
use rand;

/// Miller/Rabin primailty test.  Determines if 'n' is prime.  If it
/// returns true, 'n' is prime with a probabily of approximately
/// 1/4**k.
pub fn is_prime<T>(n: T, k: uint) -> bool
    where T: Int + rand::Rand
{
    // More tacky constants.
    let zero: T = Int::zero();
    let one: T = Int::one();
    let two = one + one;
    let three = two + one;
    let five = three + two;
    let seven = five + two;

    if n == one || n == zero {
        return false;
    }

    if n == two || n == three || n == five || n == seven {
        return true;
    }

    if n%two == zero || n%three == zero || n%five == zero || n%seven == zero {
        return false;
    }

    check(n, k)
}

fn check<T>(n: T, k: uint) -> bool
    where T: Int + rand::Rand
{
    let (s, d) = compute_sd(n);
    for _ in 0 .. k {
        if !round(n, s, d) {
            return false;
        }
    }

    return true;
}

fn round<T>(n: T, s: T, d: T) -> bool
    where T: Int + rand::Rand
{
    // This doesn't seem particularly comfortable.  From primitive will go
    // away, and hopefully be replaced with something useful.
    let one: T = Int::one();
    let two = one + one;
    let three = two + one;

    let a = rand::random::<T>() % (n - three) + two;
    // let a: T = self.rng.gen() % (n - 3) + 2;
    let mut x = exp_mod(a, d, n);

    if x == one || x == n-one {
        return true;
    }

    for _ in one .. s {
        x = (x * x) % n;
        if x == one {
            return false;
        }

        if x == n-one {
            return true;
        }
    }

    return false;
}

fn compute_sd<T>(number: T) -> (T, T)
    where T: Int
{
    let mut s: T = Int::zero();
    let mut d = number - Int::one();
    let one: T = Int::one();
    let two = one + one;

    while (d & Int::one()) == Int::zero() {
        s = s + Int::one();
        d = d / two;
    }

    (s, d)
}

pub fn exp_mod<T>(base: T, power: T, modulus: T) -> T
    where T: Int
{
    let mut p = power;
    let mut b = base;
    let mut result: T = Int::one();
    let two = result + result;

    while p > Int::zero() {
        if (p & Int::one()) != Int::zero() {
            result = (result * b) % modulus;
        }

        b = (b * b) % modulus;
        p = p / two;
    }

    result
}

#[cfg(test)]
mod test {
    use super::{exp_mod, is_prime};
    // use super::*;

    #[test]
    fn test_exp_mod() {
        assert_eq!(super::exp_mod(12345, 54321, 65211), 59112);
    }

    #[test]
    fn test_mr() {
        assert!(!is_prime(655321, 20));
        assert!(!is_prime(655323, 20));
        assert!(is_prime(655331, 20));
    }
}
