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

use permute;

define_problem!(pr024, 24, 2783915460);

fn pr024() -> u64 {
    let mut base: Vec<_> = (0u..10).map(|i| i as u8).collect();
    let mut done = false;
    for _ in 0u .. 999_999 {
        permute::next_permutation(&mut base[..], &mut done);
        assert!(!done);
    };
    show(&base[..])
}

fn show(digits: &[u8]) -> u64 {
    let mut result = 0u64;
    for &x in digits.iter() { result = result * 10 + x as u64; }
    result
}
