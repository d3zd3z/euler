// Problem 22
//
// 19 July 2002
//
//
// Using names.txt (right click and 'Save Link/Target As...'), a 46K text
// file containing over five-thousand first names, begin by sorting it into
// alphabetical order. Then working out the alphabetical value for each name,
// multiply this value by its alphabetical position in the list to obtain a
// name score.
//
// For example, when the list is sorted into alphabetical order, COLIN, which
// is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So,
// COLIN would obtain a score of 938 x 53 = 49714.
//
// What is the total of all the name scores in the file?
//
// 871198282

use std::fs;
use std::path::Path;
use std::io::prelude::*;
use crate::misc::decode_words;

define_problem!(pr022, 22, 871198282);

fn pr022() -> u64 {
    let mut file = fs::File::open(&Path::new("../haskell/names.txt")).unwrap();
    let mut line = Vec::new();
    file.read_to_end(&mut line).unwrap();
    let line = String::from_utf8(line).unwrap();
    let names = decode_words(&line[..]);
    let mut pairs = names.iter().map(|n| { name_value(&n[..]) })
        .collect::<Vec<NamePair>>();
    pairs.sort_by(|a, b| a.name.cmp(&b.name));

    let total = pairs.iter().enumerate().fold(0, |a, (bi, b)| {
        a + b.value * (bi as u64 + 1)
    });
    total
}

#[derive(Debug)]
struct NamePair {
    name: String,
    value: u64
}

fn name_value(name: &str) -> NamePair {
    let mut total = 0;
    for ch in name.chars() {
        total += ch as u64 - 'A' as u64 + 1;
    }
    NamePair { name: name.to_string(), value: total }
}
