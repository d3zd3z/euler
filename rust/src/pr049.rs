// Problem 49
//
// 01 August 2003
//
// The arithmetic sequence, 1487, 4817, 8147, in which each of the terms
// increases by 3330, is unusual in two ways: (i) each of the three terms are
// prime, and, (ii) each of the 4-digit numbers are permutations of one
// another.
//
// There are no arithmetic sequences made up of three 1-, 2-, or 3-digit
// primes, exhibiting this property, but there is one other 4-digit
// increasing sequence.
//
// What 12-digit number do you form by concatenating the three terms in this
// sequence?

use itertools::Itertools;
use misc;
use permute;
use sieve::Sieve;

define_problem!(pr049, 49, 296962999629);

fn pr049() -> u64 {
    let mut primes = Sieve::new();

    // I'm not sure if this is actually right.  It so happens that the
    // initial value of the result is prime.  The first prime of the result
    // might not be the lowest permutation, and that lowest permutation
    // might not be prime.
    for base in 1009 .. 10000 {
        if !ascending(base) {
            continue;
        }

        let perms = all_permutations(base);
        for sel in perms.iter().cloned().combinations(3) {
            if is_valid(&mut primes, &sel) {
                return sel[0] * 1_0000_0000 + sel[1] * 1_0000 + sel[2];
            }
        }
    }

    panic!("No solution found");
}

fn is_valid(primes: &mut Sieve, nums: &[u64]) -> bool {
    assert_eq!(nums.len(), 3);
    if nums[1]-nums[0] != nums[2]-nums[1] {
        return false
    }
    for &num in nums {
        if !primes.is_prime(num as usize) {
            return false
        }
    }

    if nums[0] == 1487 {
        // Per problem description, skip this one.
        return false
    }

    true
}

// Is this given number only made of monotonically increasing digits?
fn ascending(mut number: u64) -> bool {
    let mut c = 9;
    while number > 0 {
        let tmp = number % 10;
        if tmp > c {
            return false;
        }
        c = tmp;
        number /= 10;
    }

    true
}

// Generate all of the permutations of the digits of this number.
fn all_permutations(base: u64) -> Vec<u64> {
    let mut result = vec![];
    let mut work = misc::digits_of_rev(base);
    work.reverse();

    let mut done = true;
    loop {
        permute::next_permutation(&mut work, &mut done);
        if done {
            break;
        }
        result.push(misc::of_digits(&work));
    }

    result
}
