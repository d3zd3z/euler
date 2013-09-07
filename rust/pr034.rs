// Problem 34
//
// 03 January 2003
//
//
// 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
//
// Find the sum of all numbers which are equal to the sum of the factorial of
// their digits.
//
// Note: as 1! = 1 and 2! = 2 are not sums they are not included.
//
// 40730

use std::vec;

fn main() {
    let mut chainer = Chainer::new();
    chainer.chain(0, 0);

    println(format!("{}", chainer.total));
}

struct Chainer {
    total: int,
    facts: ~[uint],
    last_fact: uint
}

impl Chainer {
    fn new() -> Chainer {
        let facts = make_facts(10);
        let last = facts[9];
        Chainer { total: -3, facts: facts, last_fact: last }
    }

    fn chain(&mut self, number: uint, fact_sum: uint) {
        if number > 0 && number == fact_sum {
            self.total += number as int;
        }
        if number * 10 <= fact_sum + self.last_fact {
            for i in range(if number > 0 {0u} else {1}, 10) {
                self.chain(number * 10 + i, fact_sum + self.facts[i]);
            }
        }
    }
}

fn make_facts(limit: uint) -> ~[uint] {
    let mut result = vec::from_elem(limit, 1u);

    for i in range(2u, limit) {
        result[i] = i * result[i-1];
    }

    result
}
