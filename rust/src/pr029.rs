// Problem 29
//
// 25 October 2002
//
//
// Consider all integer combinations of a^b for 2 ≤ a ≤ 5 and 2 ≤ b ≤ 5:
//
//     2^2=4, 2^3=8, 2^4=16, 2^5=32
//     3^2=9, 3^3=27, 3^4=81, 3^5=243
//     4^2=16, 4^3=64, 4^4=256, 4^5=1024
//     5^2=25, 5^3=125, 5^4=625, 5^5=3125
//
// If they are then placed in numerical order, with any repeats removed, we
// get the following sequence of 15 distinct terms:
//
// 4, 8, 9, 16, 25, 27, 32, 64, 81, 125, 243, 256, 625, 1024, 3125
//
// How many distinct terms are in the sequence generated by a^b for 2 ≤ a ≤
// 100 and 2 ≤ b ≤ 100?
//
// 9183

use std::collections::HashSet;
use sieve::Sieve;
use sieve::Factor;

define_problem!(pr029, 29, 9183);

fn pr029() -> u64 {
    let mut primes = Sieve::new();
    let mut values = HashSet::new();

    for a in 2 .. 101 {
        let base = primes.factorize(a);

        for b in 2 .. 101 {
            let elt = power(&base, b);
            values.insert(elt);
        }
    }

    values.len() as u64
}

fn power(base: &Vec<Factor>, exp: u64) -> Vec<Factor> {
    let mut result = vec![];

    for f in base.iter() {
        result.push(Factor {prime: f.prime, power: f.power * exp as usize});
    }

    result
}
