// Problem 23
//
// 02 August 2002
//
// A perfect number is a number for which the sum of its proper divisors is
// exactly equal to the number. For example, the sum of the proper divisors
// of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect
// number.
//
// A number n is called deficient if the sum of its proper divisors is less
// than n and it is called abundant if this sum exceeds n.
//
// As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the
// smallest number that can be written as the sum of two abundant numbers is
// 24. By mathematical analysis, it can be shown that all integers greater
// than 28123 can be written as the sum of two abundant numbers. However,
// this upper limit cannot be reduced any further by analysis even though it
// is known that the greatest number that cannot be expressed as the sum of
// two abundant numbers is less than this limit.
//
// Find the sum of all the positive integers which cannot be written as the
// sum of two abundant numbers.
//
// 4179871

use std::collections::HashSet;
use std::iter;

define_problem!(pr023, 23, 4179871);

// TODO: Change this to bitv for space.  Although, it's probably
// slower.

fn pr023() -> u64 {
    let abundants = make_abundants(28124);

    let mut not_add: HashSet<u64> = HashSet::new();

    for ai in 0 .. abundants.len() {
        let a = abundants[ai];
        for b in &abundants {
            let sum = a + *b;
            if sum > 28123 {
                break;
            }
            not_add.insert(sum);
        }
    }

    let mut total = 0;
    for i in 1 .. 28124 {
        if !not_add.contains(&i) {
            total += i;
        }
    }

    total
}

fn make_abundants(limit: u64) -> Vec<u64> {
    let divisors = make_divisors(limit as usize);
    let mut result = vec![];
    for i in 1 .. limit {
        if i < divisors[i as usize] {
            result.push(i);
        }
    }
    result
}

// Since we need all of them, compute the divisor sums in advance
// using a modified sieve.
fn make_divisors(limit: usize) -> Vec<u64> {
    let mut result: Vec<_> = iter::repeat(1u64).take(limit).collect();

    for i in 2 .. limit {
        let mut n = i + i;
        while n < limit {
            result[n] += i as u64;
            n += i;
        }
    }

    result
}
