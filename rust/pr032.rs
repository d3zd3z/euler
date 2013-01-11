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

extern mod std;
use std::map;
use std::map::Set;
mod permute;

fn main() {
    let mut base = [mut 1, 2, 3, 4, 5, 6, 7, 8, 9];
    let mut done = false;

    let mut results = map::HashMap();
    loop {
        make_groupings(base, results);

        permute::next_permutation(base, &mut done);
        if done { break; }
    }

    let mut total = 0;
    for results.each_key() |k| { total += k; }
    io::println(fmt!("%u", total));
}

fn make_groupings(digits: &[u8], result: Set<uint>) {
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
        for uint::range(a, b) |x| {
            result = result * 10 + (digits[x] as uint);
        }
        result
    }

    let len = vec::len(digits);
    for uint::range(1, len-2) |i| {
        for uint::range(i+1, len-1) |j| {
            let a = piece(digits, 0, i);
            let b = piece(digits, i, j);
            let c = piece(digits, j, len);
            if a*b == c {
                map::set_add(result, c);
            }
        }
    }
}
