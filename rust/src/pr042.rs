// Problem 42
//
// 25 April 2003
//
//
// The n^th term of the sequence of triangle numbers is given by, t[n] = ½n(n
// +1); so the first ten triangle numbers are:
//
// 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
//
// By converting each letter in a word to a number corresponding to its
// alphabetical position and adding these values we form a word value. For
// example, the word value for SKY is 19 + 11 + 25 = 55 = t[10]. If the word
// value is a triangle number then we shall call the word a triangle word.
//
// Using words.txt (right click and 'Save Link/Target As...'), a 16K text
// file containing nearly two-thousand common English words, how many are
// triangle words?
//
// 162

use std::fs::File;
use std::path::Path;
use std::io::prelude::*;
use misc::{decode_words, isqrt};

define_problem!(pr042, 42, 162);

fn pr042() -> usize {
    let mut file = File::open(&Path::new("../haskell/words.txt")).unwrap();
    let mut line = String::new();
    file.read_to_string(&mut line).unwrap();
    let words = decode_words(&line[..]);
    words.iter().filter(|&w| is_triangle(name_value(&w[..]))).count()
}

fn name_value(name: &str) -> u64 {
    let mut total = 0;
    for ch in name.chars() {
        total += ch as u64 - 'A' as u64 + 1;
    }
    total
}

// Is this a triangle number.
fn is_triangle(n: u64) -> bool {
    let sqr = 1 + 8 * n;
    let root = isqrt(sqr);
    sqr == root * root
}
