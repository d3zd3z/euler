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

use std::mem::replace;

define_problem!(pr017, 17, 21124);

fn pr017() -> u64 {
    let mut conv = Converter::new();
    let mut result = 0;

    for i in 1 .. 1001 {
        let text = conv.make_english(i);
        // println(fmt!("%4u '%s'", i, text));
        result += count_letters(&text[..]);
    }

    result
}

fn count_letters(text: &str) -> u64 {
    let mut count = 0;
    for ch in text.chars() {
        if ch.is_alphabetic() {
            count += 1;
        }
    }
    count
}

struct Converter {
    buffer: String,
    add_space: bool
}

impl Converter {
    pub fn new() -> Box<Converter> {
        Box::new(Converter {
            add_space: false,
            buffer: String::new()
        })
    }
}

impl Converter {
    fn make_english(&mut self, n: u64) -> String {
        self.add_space = false;
        self.buffer = String::new();
        let mut work = n;

        if work > 1000 { panic!("Number too large") }

        if work == 1000 { return "one thousand".to_string() }

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

    fn add_ones(&mut self, n: u64) {
        self.add(ONES[n as usize - 1]);
    }

    fn add_tens(&mut self, n: u64) {
        self.add(TENS[n as usize - 1]);
    }

    fn add(&mut self, text: &str) {
        if self.add_space {
            self.buffer.push(' ');
        }
        self.buffer.push_str(text);
        self.add_space = true;
    }
}

static ONES: &[&str] = &[
    "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
    "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen",
    "seventeen", "eighteen", "nineteen"
];

static TENS: &[&str] = &[
    "ten", "twenty", "thirty", "forty", "fifty",
    "sixty", "seventy", "eighty", "ninety"
];
