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

extern mod extra;
use std::cmp;
use std::io;
use std::str;

fn main() {
    let mut file = io::File::open(&Path::new("../haskell/names.txt"));
    let line = file.read_to_end();
    let line = str::from_utf8_owned(line);
    let names = decode_names(line);
    let mut pairs = names.map(|n| { ~name_value(n) });
    pairs.sort_by(pair_le);

    let mut total = 0;
    // for pairs.eachi |i, p| {
    // Not sure how this is supposed to be done in rust now.
    for i in range(0, pairs.len()) {
        total += pairs[i].value * (i + 1);
    }
    println(format!("{}", total));
}

struct NamePair {
    name: ~str,
    value: uint
}

fn pair_le(a: &~NamePair, b: &~NamePair) -> cmp::Ordering {
    a.name.cmp(&b.name)
}

fn decode_names(line: &str) -> ~[~str] {
    let mut result = ~[];
    let mut name = ~"";

    for ch in line.chars() {
        match ch {
            '"' => (),
            ',' => {
                // TODO: Can this be moved?
                result.push(name);
                name = ~"";
            },
            ch => {
                name.push_char(ch);
            }
        }
    }
    result.push(name);

    result
}

fn name_value(name: &~str) -> NamePair {
    let mut total = 0;
    for ch in name.chars() {
        total += ch as uint - 'A' as uint + 1;
    }
    NamePair { name: name.clone(), value: total }
}
