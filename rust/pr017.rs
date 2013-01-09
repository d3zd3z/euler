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

// use std;
// import std::rope;

// TODO: Try with ropes.

fn main() {
    let conv = Converter();
    let mut result = 0;

    for uint::range(1, 1001) |i| {
        let text = conv.to_english(i);
        // io::println(fmt!("%4u %s", i, text));
        result += count_letters(text);
    }

    io::println(fmt!("%u", result));
}

fn count_letters(text: &str) -> uint {
    let mut count = 0;
    for str::each_char(text) |ch| {
        if char::is_alphabetic(ch) {
            count += 1;
        }
    }
    count
}

struct Converter {
    ones: ~[~str],
    tens: ~[~str],
    mut buffer: ~str,
    mut add_space: bool
}

fn Converter() -> ~Converter {
    ~Converter {
        ones: make_ones(),
        tens: make_tens(),
        add_space: false,
        buffer: ~""
    }
}

impl Converter {
    fn to_english(n: uint) -> ~str {
        self.add_space = false;
        self.buffer = ~"";
        let mut work = n;

        if work > 1000 { fail ~"Number too large" }

        if work == 1000 { return ~"one thousand" }

        if work >= 100 {
            self.add(self.ones[work/100 - 1]);
            self.add("hundred");

            work %= 100;
            if work > 0 {
                self.add("and");
            }
        }

        if work >= 20 {
            self.add(self.tens[work/10 - 1]);
            work %= 10;

            if work > 0 {
                self.add_space = false;
                self.add("-");
                self.add_space = false;
            }
        }

        if work >= 1 {
            self.add(self.ones[work-1]);
        }

        let result = copy self.buffer;
        self.buffer = ~"";
        return result;
    }

    fn add(text: &str) {
        if self.add_space {
            self.buffer += " ";
        }
        self.buffer += text;
        self.add_space = true;
    }
}

/*
class converter {
    let ones: ~[str];
    let tens: ~[str];
    let mut buffer: str;
    let mut add_space: bool;

    new() {
        self.ones = make_ones();
        self.tens = make_tens();
        self.add_space = false;
        self.buffer = "";
    }

}
*/

fn make_ones() -> ~[~str] {
    ~[~"one", ~"two", ~"three", ~"four", ~"five", ~"six", ~"seven",
      ~"eight", ~"nine", ~"ten", ~"eleven", ~"twelve", ~"thirteen",
      ~"fourteen", ~"fifteen", ~"sixteen", ~"seventeen", ~"eighteen",
      ~"nineteen"]
}

fn make_tens() -> ~[~str] {
    ~[~"ten", ~"twenty", ~"thirty", ~"forty", ~"fifty",
      ~"sixty", ~"seventy", ~"eighty", ~"ninety"]
}
