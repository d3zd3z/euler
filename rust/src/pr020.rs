// Problem 20
//
// 21 June 2002
//
//
// n! means n x (n − 1) x ... x 3 x 2 x 1
//
// For example, 10! = 10 x 9 x ... x 3 x 2 x 1 = 3628800,
// and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 =
// 27.
//
// Find the sum of the digits in the number 100!
//
// 648

// This is easier to do by using something like base 10_000 (100**2).

use std::iter;

define_problem!(pr020, 20, 648);

static BASE: u64 = 10_000;

fn pr020() -> u64 {
    static SIZE: usize = 40;
    let mut acc: Vec<_> = iter::repeat(0).take(SIZE).collect();

    acc[0] = 1;

    for x in 2 .. 101 {
        multiply(acc.as_mut_slice(), x);
    }
    sum_digits(&acc[..])
}

// Multiply the little-endian base 10_000 number in 'acc' by 'by'.
fn multiply(acc: &mut [u64], by: u64) {
    let mut carry = 0;
    for i in 0 .. acc.len() {
        let temp = acc[i] * by + carry;
        acc[i] = temp % BASE;
        carry = temp / BASE;
    }
    if carry != 0 { panic!("Multiply overflow") }
}

fn sum_digits(acc: &[u64]) -> u64 {
    acc.iter().fold(0, |accum, &n| {
        let mut sub = 0;
        let mut tmp = n;
        while tmp > 0 {
            sub += tmp % 10;
            tmp /= 10;
        }
        accum + sub
    })
}
