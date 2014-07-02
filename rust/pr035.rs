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

use sieve::Sieve;

define_problem!(main, 35)

fn main() {
    let mut sv = Sieve::new();

    let mut count = 0u;

    let mut p = 2;
    while p < 1_000_000 {
        let rots = number_rotations(p);
        if rots.iter().all(|i| { sv.is_prime(*i) }) {
            count += 1;
        }
        p = sv.next_prime(p);
    }

    println!("{}", count);
}

// How many digits are in this number.
fn digit_count(num: uint) -> uint {
    let mut tmp = num;
    let mut result = 0;
    while tmp > 0 {
        result += 1;
        tmp /= 10;
    }
    result
}

// Integer exponentiation.
fn expt(n: uint, pow: uint) -> uint {
    let mut result = 1u;
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
fn number_rotations(num: uint) -> Vec<uint> {
    let mut result = vec![];
    let len = digit_count(num);
    let highest_one = expt(10, len-1);

    let mut right = highest_one;
    let mut left = 1u;
    let mut accum = 0u;
    let mut n = num;
    while left < highest_one {
        let n_quot = n / 10;
        let n_rem = n % 10;
        let new_accum = accum + left * n_rem;
        let next = n_quot + right * new_accum;

        right = right / 10;
        left = left * 10;
        accum = new_accum;
        n = n_quot;
        result.push(next);
    }
    result
}
