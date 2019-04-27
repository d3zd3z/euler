// Problem 21
//
// 05 July 2002
//
//
// Let d(n) be defined as the sum of proper divisors of n (numbers less than
// n which divide evenly into n).
// If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair
// and each of a and b are called amicable numbers.
//
// For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22,
// 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1,
// 2, 4, 71 and 142; so d(284) = 220.
//
// Evaluate the sum of all the amicable numbers under 10000.
//
// 31626

use crate::sieve::Sieve;
use crate::sieve;

define_problem!(pr021, 21, 31626);

fn pr021() -> u64 {
    let mut pv = Sieve::new();

    let mut sum = 0;
    for i in 1 .. 10_000 {
        if pv.is_amicable(i) {
            sum += i;
        }
    }

    sum
}

trait Amicable {
    fn is_amicable(&mut self, a: u64) -> bool;
    fn proper_div_sum(&mut self, a: u64) -> u64;
}

impl Amicable for sieve::Sieve {
    fn is_amicable(&mut self, a: u64) -> bool {
        let b = self.proper_div_sum(a);
        if a == b || b == 0 { return false }
        let c = self.proper_div_sum(b);
        a == c
    }

    fn proper_div_sum(&mut self, a: u64) -> u64 {
        let divs = self.divisors(a as usize);
        let sum = divs.iter().fold(0, |tot, x| tot + *x);
        sum as u64 - a
    }
}
