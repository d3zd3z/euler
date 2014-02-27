// Problem 40
//
// 28 March 2003
//
//
// An irrational decimal fraction is created by concatenating the positive
// integers:
//
// 0.123456789101112131415161718192021...
//
// It can be seen that the 12^th digit of the fractional part is 1.
//
// If d[n] represents the n^th digit of the fractional part, find the value
// of the following expression.
//
// d[1] x d[10] x d[100] x d[1000] x d[10000] x d[100000] x d[1000000]
//
// 210

fn main() {
    let mut st = State::new();

    let mut i = 1;
    while !st.done() {
        st.add_number(i);
        i += 1;
    }

    println(format!("{}", st.product));
}

struct State {
    count: uint,
    next: uint,
    product: uint
}

impl State {
    fn new() -> State {
        State { count: 1, next: 1, product: 1 }
    }

    fn done(&self) -> bool {
        self.next > 1_000_000
    }

    fn add_digit(&mut self, digit: uint) {
        if self.count == self.next {
            self.product *= digit;
            self.next *= 10;
        }
        self.count += 1;
    }

    fn add_number(&mut self, number: uint) {
        let digits = digits_of(number);
        for digit in digits.iter() {
            self.add_digit(*digit);
        }
    }
}

// Return the digits, in order.
fn digits_of(number: uint) -> ~[uint] {
    let mut result = ~[];
    let mut number = number;
    while number > 0 {
        result.unshift(number % 10);
        number /= 10;
    }
    result
}
