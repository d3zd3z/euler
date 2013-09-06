// Problem 32
//
// 06 December 2002
//
//
// We shall say that an n-digit number is pandigital if it makes use of all
// the digits 1 to n exactly once; for example, the 5-digit number, 15234, is
// 1 through 5 pandigital.
//
// The product 7254 is unusual, as the identity, 39 x 186 = 7254, containing
// multiplicand, multiplier, and product is 1 through 9 pandigital.
//
// Find the sum of all products whose multiplicand/multiplier/product
// identity can be written as a 1 through 9 pandigital.
//
// HINT: Some products can be obtained in more than one way so be sure to
// only include it once in your sum.
//
// 45228

use std::hashmap::HashSet;

mod permute;

fn main() {
    let mut base = [1u8, 2, 3, 4, 5, 6, 7, 8, 9];
    let mut done = false;

    let mut results = HashSet::new();
    loop {
        make_groupings(base, &mut results);

        permute::next_permutation(base, &mut done);
        if done { break; }
    }

    let mut total = 0;
    for k in results.iter() { total += *k; }
    println(format!("{}", total));
}

fn make_groupings(digits: &[u8], result: &mut HashSet<uint>) {
    // Internal functions in Rust do not capture their environment.
    // Lambda expressions do, and it might seem that this could just
    // be:
    //   let piece = |a, b| { ... }
    // However, that then fails with "value may contain borrowed
    // pointers."  So, apparently, it doesn't care that 'piece' never
    // escapes, and so the pointer is still valid.
    // Certainly interactions between the various pointer types, and
    // typical lambda-calculus stuff.
    fn piece(digits: &[u8], a: uint, b: uint) -> uint {
        let mut result = 0;
        for x in range(a, b) {
            result = result * 10 + (digits[x] as uint);
        }
        result
    }

    let len = digits.len();
    for i in range(1, len-2) {
        for j in range(i+1, len-1) {
            let a = piece(digits, 0, i);
            let b = piece(digits, i, j);
            let c = piece(digits, j, len);
            if a*b == c {
                result.insert(c);
            }
        }
    }
}
