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

extern mod std;
use std::sort;

fn main() {
    let lineresult = io::read_whole_file_str(&Path("../haskell/names.txt"));
    let line = result::unwrap(lineresult);
    let names = decode_names(line);
    let pairs = names.map(|n| { @name_value(n) });
    let pairs = sort::merge_sort(pair_le, pairs);

    let mut total = 0;
    for pairs.eachi |i, p| {
        // io::println(fmt!("%5u %10s %u", i+1, p.name, p.value));
        total += p.value * (i + 1);
    }
    io::println(fmt!("%u", total));

    // io::println(fmt!("len = %u", line.len()));
    // io::println(fmt!("len2 = %u", names.len()));
}

struct NamePair {
    name: ~str,
    value: uint
}

pure fn pair_le(a: &@NamePair, b: &@NamePair) -> bool {
    a.name <= b.name
}

fn decode_names(line: &str) -> ~[~str] {
    let mut result = ~[];
    let mut name = ~"";

    for line.each_char() |ch| {
        match ch {
            '"' => (),
            ',' => {
                // TODO: Can this be moved?
                result.push(copy name);
                name = ~"";
            },
            ch => {
                str::push_char(&mut name, ch);
            }
        }
    }
    result.push(copy name);

    result
}

fn name_value(name: &~str) -> NamePair {
    let mut total = 0;
    for name.each_char() |ch| {
        total += ch as uint - 'A' as uint + 1;
    }
    NamePair { name: copy *name, value: total }
}
