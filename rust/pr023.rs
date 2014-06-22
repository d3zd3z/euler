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

extern crate collections;
use std::collections::hashmap::HashSet;

// TODO: Change this to bitv for space.  Although, it's probably
// slower.

fn main() {
    let abundants = make_abundants(28124);

    let mut notAdd: HashSet<uint> = HashSet::new();

    for ai in range(0u, abundants.len()) {
        let a = *abundants.get(ai);
        for bi in range(ai, abundants.len()) {
            let sum = a + *abundants.get(bi);
            if sum > 28123 {
                break;
            }
            notAdd.insert(sum);
        }
    }

    let mut total = 0u;
    for i in range(1u, 28124) {
        if !notAdd.contains(&i) {
            total += i;
        }
    }
    println!("{}", total);
}

fn make_abundants(limit: uint) -> Vec<uint> {
    let divisors = make_divisors(limit);
    let mut result = vec![];
    for i in range(1, limit) {
        if i < *divisors.get(i) {
            result.push(i);
        }
    }
    result
}

// Since we need all of them, compute the divisor sums in advance
// using a modified sieve.
fn make_divisors(limit: uint) -> Vec<uint> {
    let mut result = Vec::from_elem(limit, 1u);

    for i in range(2u, limit) {
        let mut n = i + i;
        while n < limit {
            *result.get_mut(n) += i;
            n += i;
        }
    }

    result
}
