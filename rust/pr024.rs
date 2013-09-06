// Problem 24
//
// 16 August 2002
//
//
// A permutation is an ordered arrangement of objects. For example, 3124 is
// one possible permutation of the digits 1, 2, 3 and 4. If all of the
// permutations are listed numerically or alphabetically, we call it
// lexicographic order. The lexicographic permutations of 0, 1 and 2 are:
//
// 012   021   102   120   201   210
//
// What is the millionth lexicographic permutation of the digits 0, 1, 2, 3,
// 4, 5, 6, 7, 8 and 9?
//
// 2783915460

// TODO: With rust 0.5, this produces the wrong result.

use std::vec;

mod permute;

fn main() {
    let mut base = do vec::from_fn(10) |i| {i as u8};
    let mut done = false;
    do 999_999.times() {
        permute::next_permutation(base, &mut done);
        assert!(!done);
    }
    show(base);
}

fn show(digits: &[u8]) {
    let mut result = ~"";
    for x in digits.iter() { result.push_str(x.to_str()); }
    println(result);
}
