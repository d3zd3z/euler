// Problem 41
//
// 11 April 2003
//
// We shall say that an n-digit number is pandigital if it makes use of all
// the digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital
// and is also prime.
//
// What is the largest n-digit pandigital prime that exists?
//
// 7652413

// Since the digits 1-9 sum to 45 and 1-8 sum to 36, indicating that
// both will always be a multiple of three, we know that the largest
// pandigital prime can be at most 7 digits.  As long as there is at
// least one 7 digit pandigital prime, it will be larger than any
// smaller pandigital primes.

use crate::sieve::Sieve;

define_problem!(pr041, 41, 7652413);

fn pr041() -> u64 {
    let mut primes = Sieve::new();

    let mut p = 9_999_999;
    loop {
        p = primes.prev_prime(p as usize) as u64;
        if is_pandigital(p) {
            break;
        }
    }

    p
}

// Determine if the given number uses all of the digits 1-9.
fn is_pandigital(num: u64) -> bool {
    let mut digits = 0;

    let mut num = num;
    let mut count = 0;
    while num > 0 {
        let dig = num % 10;
        let bit = 1 << dig;
        if digits & bit != 0 {
            return false
        }
        digits |= bit;
        num /= 10;
        count += 1;
    }

    digits == (2 << count) - 2
}

#[test]
fn test_is_pandigital() {
    assert!(is_pandigital(12345));
    assert!(is_pandigital(192384576));
    assert!(!is_pandigital(1923845767));
    assert!(!is_pandigital(19238476));
}
