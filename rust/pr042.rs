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

use std::io;
use misc::{decode_words, isqrt};

define_problem!(solve, 42)

fn solve() {
    let mut file = io::File::open(&Path::new("../haskell/words.txt"));
    let line = file.read_to_str().unwrap();
    let words = decode_words(line.as_slice());
    let result = words.iter().filter(|&w| is_triangle(name_value(w.as_slice()))).count();
    println!("{}", result);
}

fn name_value(name: &str) -> uint {
    let mut total = 0;
    for ch in name.chars() {
        total += ch as uint - 'A' as uint + 1;
    }
    total
}

// Is this a triangle number.
fn is_triangle(n: uint) -> bool {
    let sqr = 1 + 8 * n;
    let root = isqrt(sqr);
    sqr == root * root
}
