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

// extern mod extra;
use std::cmp;
use std::io;
use misc::decode_words;

define_problem!(main, 22);

fn main() {
    let mut file = io::File::open(&Path::new("../haskell/names.txt"));
    let line = file.read_to_end().unwrap();
    let line = String::from_utf8(line).unwrap();
    let names = decode_words(line.as_slice());
    let mut pairs = names.iter().map(|n| { box name_value(n.as_slice()) })
        .collect::<Vec<Box<NamePair>>>();
    pairs.sort_by(pair_le);

    let total = pairs.iter().enumerate().fold(0, |a, (bi, b)| {
        a + b.value * (bi + 1)
    });
    /*
    let mut total = 0;
    for i in range(0, pairs.len()) {
        total += pairs.get(i).value * (i + 1);
    }
    */
    println!("{}", total);
}

#[deriving(Show)]
struct NamePair {
    name: String,
    value: uint
}

fn pair_le(a: &Box<NamePair>, b: &Box<NamePair>) -> cmp::Ordering {
    a.name.cmp(&b.name)
}

fn name_value(name: &str) -> NamePair {
    let mut total = 0;
    for ch in name.chars() {
        total += ch as uint - 'A' as uint + 1;
    }
    NamePair { name: name.to_string(), value: total }
}
