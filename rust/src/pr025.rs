// Problem 25
//
// 30 August 2002
//
//
// The Fibonacci sequence is defined by the recurrence relation:
//
//     F[n] = F[n−1] + F[n−2], where F[1] = 1 and F[2] = 1.
//
// Hence the first 12 terms will be:
//
//     F[1] = 1
//     F[2] = 1
//     F[3] = 2
//     F[4] = 3
//     F[5] = 5
//     F[6] = 8
//     F[7] = 13
//     F[8] = 21
//     F[9] = 34
//     F[10] = 55
//     F[11] = 89
//     F[12] = 144
//
// The 12th term, F[12], is the first term to contain three digits.
//
// What is the first term in the Fibonacci sequence to contain 1000 digits?
//
// 4782

use num::BigUint;
use num::bigint::ToBigUint;
use std::ops::{Add, Mul};

define_problem!(pr025, 25, 4782);

fn pr025() -> u64 {
    let mut a = 1.to_biguint().unwrap();
    let mut b = 1.to_biguint().unwrap();
    let stop = exp10(999);

    let mut count = 2;
    while b < stop {
        let tmp = a.add(&b);
        a = b;
        b = tmp;
        count += 1;
    }
    count
}

// Return 10 to the given power.
fn exp10(n: u64) -> BigUint {
    let mut work = 1.to_biguint().unwrap();
    let ten = 10.to_biguint().unwrap();

    for _ in 0 .. n {
        work = work.mul(&ten);
    }

    work
}

/*
 * TODO: Fix up this version.
use std::vec;

static digits: u64 = 999;

fn main() {
    let mut a = Vec::from_elem(digits, 0u8);
    let mut b = Vec::from_elem(digits, 0u8);

    *a.get_mut(0) = 1
    a[0] = 1;
    b[0] = 1;
    let mut count = 3;

    let mut overflowed = false;
    loop {
        add(a, b, &mut overflowed);
        if overflowed { break; }
        count += 1;

        add(b, a, &mut overflowed);
        if overflowed { break; }
        count += 1;
    }
    println!("{}", count);
}

fn add(dest: &mut [u8], other: &mut [u8],
       overflowed: &mut bool)
{
    let mut carry = 0u8;
    for i in range(0, dest.len()) {
        let temp = dest[i] + other[i] + carry;
        dest[i] = temp % 10;
        carry = temp / 10;
    }

    *overflowed = carry != 0;
}
*/
