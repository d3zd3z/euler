// Problem 35
//
// 17 January 2003
//
//
// The number, 197, is called a circular prime because all rotations of the
// digits: 197, 971, and 719, are themselves prime.
//
// There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37,
// 71, 73, 79, and 97.
//
// How many circular primes are there below one million?
//
// 55

use crate::sieve::Sieve;

define_problem!(pr035, 35, 55);

fn pr035() -> u64 {
    let mut sv = Sieve::new();

    let mut count = 0;

    let mut p = 2;
    while p < 1_000_000 {
        let rots = number_rotations(p);
        if rots.iter().all(|i| { sv.is_prime(*i as usize) }) {
            count += 1;
        }
        p = sv.next_prime(p as usize) as u64;
    }

    count
}

// How many digits are in this number.
fn digit_count(num: u64) -> u64 {
    let mut tmp = num;
    let mut result = 0;
    while tmp > 0 {
        result += 1;
        tmp /= 10;
    }
    result
}

// Integer exponentiation.
fn expt(n: u64, pow: u64) -> u64 {
    let mut result = 1;
    let mut n = n;
    let mut pow = pow;

    while pow > 0 {
        if (pow & 1) != 0 {
            result *= n;
        }
        n *= n;
        pow >>= 1;
    }
    result
}

// Generate all of the rotations of a number, not including the
// original.
fn number_rotations(num: u64) -> Vec<u64> {
    let mut result = vec![];
    let len = digit_count(num);
    let highest_one = expt(10, len-1);

    let mut right = highest_one;
    let mut left = 1;
    let mut accum = 0;
    let mut n = num;
    while left < highest_one {
        let n_quot = n / 10;
        let n_rem = n % 10;
        let new_accum = accum + left * n_rem;
        let next = n_quot + right * new_accum;

        right /= 10;
        left *= 10;
        accum = new_accum;
        n = n_quot;
        result.push(next);
    }
    result
}
