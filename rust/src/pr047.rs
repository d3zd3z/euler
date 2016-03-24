// Problem 47
//
// 04 July 2003
//
//
// The first two consecutive numbers to have two distinct prime factors are:
//
// 14 = 2 x 7
// 15 = 3 x 5
//
// The first three consecutive numbers to have three distinct prime factors
// are:
//
// 644 = 2^2 x 7 x 23
// 645 = 3 x 5 x 43
// 646 = 2 x 17 x 19.
//
// Find the first four consecutive integers to have four distinct primes
// factors. What is the first of these numbers?

use sieve::Sieve;

define_problem!(pr047, 47, 134043);

const EXPECT: usize = 4;

fn pr047() -> usize {
    let mut sieve = Sieve::new();

    let mut count = 0;
    for i in 2.. {
        let factors = sieve.factorize(i);
        if factors.len() == EXPECT {
            count += 1;
            if count == EXPECT {
                return i - EXPECT + 1;
            }
        } else {
                count = 0;
        }
    }
    unreachable!();
}
