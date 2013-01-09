// A simple prime number sieve.

/*
export t, make;
export is_prime;
export next_prime;
export factorize;
export divisors;
*/

use std::bitv::*;
use std::sort;

const default_size: uint = 8192u;

pub struct Sieve {
    mut vec: @Bitv, mut limit: uint
}

pub fn Sieve() -> Sieve {
    let result = Sieve { vec: @Bitv(default_size + 1, true),
        limit: default_size };
    result.fill();
    result
}

priv impl Sieve {
    fn fill() {
        self.vec.set_all();
        self.vec.set(0, false);
        self.vec.set(1, false);

        let mut pos = 2u;
        let limit = self.limit;
        while pos <= limit {
            if !self.vec.get(pos) {
                pos += 2;
            } else {
                let mut n = pos + pos;
                while n <= limit {
                    self.vec.set(n, false);
                    n += pos;
                }
                if pos == 2 {
                    pos += 1;
                } else {
                    pos += 2;
                }
            }
        }
    }
}

impl Sieve {
    fn is_prime(n: uint) -> bool {
        if n >= self.limit {
            let mut new_limit = self.limit;
            while new_limit < n {
                new_limit *= 8;
            }

            self.vec = @Bitv(new_limit + 1, true);
            self.limit = new_limit;
            self.fill();
        }

        self.vec.get(n)
    }

    fn next_prime(n: uint) -> uint {
        if n == 2 {
            return 3;
        }

        let mut next = n + 2;
        while !self.is_prime(next) {
            next += 2;
        }
        next
    }

    fn factorize(n: uint) -> ~[Factor] {
        let mut result = ~[];
        let mut tmp = n;
        let mut prime = 2;
        let mut count = 0;

        while tmp > 1 {
            if tmp % prime == 0 {
                tmp /= prime;
                count += 1;
            } else {
                if count > 0 {
                    result.push(Factor {prime: prime, power: count});
                    count = 0;
                }

                if tmp > 1 {
                    prime = self.next_prime(prime);
                }
            }
        }

        if count > 0 {
            result.push(Factor {prime: prime, power: count});
        }

        result
    }

    fn divisors(n: uint) -> ~[uint] {
        let factors = self.factorize(n);
        let mut result = ~[];
        spread(factors, &mut result);
        do sort::merge_sort(result) |a, b| { *a <= *b }
    }
}

fn spread(factors: &[Factor], result: &mut ~[uint]) {
    let len = factors.len();
    if len == 0 {
        result.push(1);
    } else {
        let mut rest = ~[];
        let x = factors[0];
        spread(factors.slice(1, len), &mut rest);

        let mut power = 1;
        for uint::range(0, x.power + 1) |i| {
            for rest.each() |elt| {
                result.push(*elt * power);
            }
            if i < power {
                power *= x.prime;
            }
        }
    }
}

struct Factor {
    prime: uint,
    power: uint
}

// Comparison on Factor.
impl Factor: cmp::Eq {
    #[inline(always)]
    pure fn eq(&self, other: &Factor) -> bool {
        self.prime == other.prime &&
            self.power == other.power
    }
    #[inline(always)]
    pure fn ne(&self, other: &Factor) -> bool {
        !self.eq(other)
    }
}

impl Factor: to_bytes::IterBytes {
    pure fn iter_bytes(&self, lsb: bool, f: to_bytes::Cb) {
        self.prime.iter_bytes(lsb, f);
        self.power.iter_bytes(lsb, f);
    }
}
