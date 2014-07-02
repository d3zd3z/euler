// Problem 17
//
// 17 May 2002
//
//
// If the numbers 1 to 5 are written out in words: one, two, three, four,
// five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
//
// If all the numbers from 1 to 1000 (one thousand) inclusive were written
// out in words, how many letters would be used?
//
//
// NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and
// forty-two) contains 23 letters and 115 (one hundred and fifteen) contains
// 20 letters. The use of "and" when writing out numbers is in compliance
// with British usage.
//
// 21124

use std::char;
use std::mem::replace;

define_problem!(main, 17)

// TODO: Try with ropes.

fn main() {
    let mut conv = Converter::new();
    let mut result = 0;

    for i in range(1u, 1001) {
        let text = conv.to_english(i);
        // println(fmt!("%4u '%s'", i, text));
        result += count_letters(text.as_slice());
    }

    println!("{}", result);
}

fn count_letters(text: &str) -> uint {
    let mut count = 0;
    for ch in text.chars() {
        if char::is_alphabetic(ch) {
            count += 1;
        }
    }
    count
}

struct Converter {
    ones: Vec<&'static str>,
    tens: Vec<&'static str>,
    buffer: String,
    add_space: bool
}

impl Converter {
    pub fn new() -> Box<Converter> {
        box Converter {
            ones: make_ones(),
            tens: make_tens(),
            add_space: false,
            buffer: String::new()
        }
    }
}

impl Converter {
    fn to_english(&mut self, n: uint) -> String {
        self.add_space = false;
        self.buffer = String::new();
        let mut work = n;

        if work > 1000 { fail!("Number too large") }

        if work == 1000 { return String::from_str("one thousand") }

        if work >= 100 {
            self.add_ones(work/100);
            self.add("hundred");

            work %= 100;
            if work > 0 {
                self.add("and");
            }
        }

        if work >= 20 {
            self.add_tens(work/10);
            work %= 10;

            if work > 0 {
                self.add_space = false;
                self.add("-");
                self.add_space = false;
            }
        }

        if work >= 1 {
            self.add_ones(work);
        }
        // let result = copy self.buffer;

        replace(&mut self.buffer, String::new())
    }

    fn add_ones(&mut self, n: uint) {
        let piece = String::from_str(*self.ones.get(n - 1));
        self.add(piece.as_slice());
    }

    fn add_tens(&mut self, n: uint) {
        let piece = String::from_str(*self.tens.get(n - 1));
        self.add(piece.as_slice());
    }

    fn add(&mut self, text: &str) {
        if self.add_space {
            self.buffer.push_char(' ');
        }
        self.buffer.push_str(text);
        self.add_space = true;
    }
}

fn make_ones() -> Vec<&'static str> {
    vec!["one", "two", "three", "four", "five", "six", "seven",
      "eight", "nine", "ten", "eleven", "twelve", "thirteen",
      "fourteen", "fifteen", "sixteen", "seventeen", "eighteen",
      "nineteen"]
}

fn make_tens() -> Vec<&'static str> {
    vec!["ten", "twenty", "thirty", "forty", "fifty",
      "sixty", "seventy", "eighty", "ninety"]
}
