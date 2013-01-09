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

use sieve::Sieve;

// TODO: Change this to bitv for space.  Although, it's probably
// slower.

fn main() {
    let pv = Sieve();

    let abundants = do vec::from_fn(28124) |i| { pv.is_abundant(i) };
    let paired = vec::to_mut(vec::from_elem(28124, false));
    for uint::range(12, 28124) |i| {
        for uint::range(i, 28124) |j| {
            if i + j < 28124 && abundants[i] && abundants[j] {
                paired[i+j] = true
            }
        }
    }

    let mut total = 0;
    for uint::range(1, 28124) |i| {
        if !paired[i] {
            total += i
        }
    }
    io::println(fmt!("%u", total));
}

impl Sieve {
    fn is_abundant(a: uint) -> bool {
        self.proper_div_sum(a) > a
    }

    fn proper_div_sum(a: uint) -> uint {
        let divs = self.divisors(a);
        let sum = divs.foldl(0, |tot, x| { *tot + *x });
        sum - a
    }
}
