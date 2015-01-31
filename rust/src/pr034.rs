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

use std::iter;

define_problem!(pr034, 34, 40730);

fn pr034() -> int {
    let mut chainer = Chainer::new();
    chainer.chain(0, 0);

    chainer.total
}

struct Chainer {
    total: int,
    facts: Vec<uint>,
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
            for i in (if number > 0 {0u} else {1}) .. 10 {
                let elt = self.facts[i];
                self.chain(number * 10 + i, fact_sum + elt);
            }
        }
    }
}

fn make_facts(limit: uint) -> Vec<uint> {
    let mut result: Vec<_> = iter::repeat(1u).take(limit).collect();

    for i in 2u .. limit {
        result[i] = i * result[i-1];
    }

    result
}
