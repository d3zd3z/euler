// Problem 16
//
// 03 May 2002
//
//
// 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
//
// What is the sum of the digits of the number 2^1000?
//
//
// 1366

use std::iter;

define_problem!(pr016, 16, 1366);

fn pr016() -> u64 {
    static SIZE: usize = 302;
    let mut digits: Vec<_> = iter::repeat(0u8).take(SIZE).collect();
    digits[0] = 1;
 
    for _x in 0 .. 1000 {
        double(&mut digits[..]);
    }

    let result = digits.iter().fold(0, |accum, n| {
        accum + *n as u64
    });

    result
}

fn double(digits: &mut [u8]) {
    let mut carry = 0;
    for i in 0 .. digits.len() {
        let temp = digits[i] * 2 + carry;
        digits[i] = temp % 10;
        carry = temp / 10;
    }

    if carry != 0 { panic!("Numeric overflow"); }
}
