// Problem 14
//
// 05 April 2002
//
//
// The following iterative sequence is defined for the set of positive
// integers:
//
// n → n/2 (n is even)
// n → 3n + 1 (n is odd)
//
// Using the rule above and starting with 13, we generate the following
// sequence:
//
// 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
//
// It can be seen that this sequence (starting at 13 and finishing at 1)
// contains 10 terms. Although it has not been proved yet (Collatz Problem),
// it is thought that all starting numbers finish at 1.
//
// Which starting number, under one million, produces the longest chain?
//
// NOTE: Once the chain starts the terms are allowed to go above one million.
//
// 837799

use std::iter;

define_problem!(main, 14);

fn main() {
    if false {
        let mut l = box Noncached;
        compute_len(&mut *l);
    }
    if true {
        let mut l = box EnumCache::new();
        compute_len(&mut *l);
    }

    /*
    println!("size: {}", mem::size_of::<~Lengther>());
    println!("size: {}", mem::size_of::<EnumCache>());
    println!("size: {}", mem::size_of::<Noncached>());
    */
}

trait Lengther {
    fn chain_len(&mut self, n: uint) -> uint;
}

fn compute_len<T: Lengther>(l: &mut T) {
    let mut max_len = 0;
    let mut max = 0;
    for x in range(1u, 1_000_000) {
        let len = l.chain_len(x);
        if len > max_len {
            max_len = len;
            max = x;
        }
    }
    println!("chain {}, len {}", max, max_len);
}

struct Noncached;

impl Lengther for Noncached {
    #[cfg(less_efficient_recursive_version)]
    fn chain_len(&mut self, n: uint) -> uint {
        if n == 1 {
            1
        } else if n & 1 == 0 {
            1 + self.chain_len(n >> 1)
        } else {
            1 + self.chain_len(3 * n + 1)
        }
    }

    // Speed this up, with an iterative version.
    fn chain_len(&mut self, n: uint) -> uint {
        let mut n = n;
        let mut len = 1;
        while n > 1 {
            len += 1;
            if n & 1 == 0 {
                n >>= 1;
            } else {
                n = n * 3 + 1;
            }
        }
        len
    }
}

/* Cached version, attempting to speed things up. */
struct EnumCache {
    size: uint,
    cache: Vec<Info>
}

#[derive(Clone, PartialEq, Eq)]
enum Info {
    Unknown,
    Known(uint)
}

impl EnumCache {
    fn new() -> EnumCache {
        let size = 100000;
        EnumCache {
            size: size,
            cache: iter::repeat(Info::Unknown).take(size).collect(),
        }
    }
}

impl Lengther for EnumCache {
    fn chain_len(&mut self, n: uint) -> uint {
        if n < self.size {
            match self.cache[n] {
                Info::Unknown => {
                    let answer = self.chain2(n);
                    self.cache[n] = Info::Known(answer);
                    answer
                }
                Info::Known(x) => x
            }
        } else {
            self.chain2(n)
        }
    }
}

impl EnumCache {
    fn chain2(&mut self, n: uint) -> uint {
        if n == 1 {
            1
        } else if n & 1 == 0 {
            1 + self.chain_len(n >> 1)
        } else {
            1 + self.chain_len(3 * n + 1)
        }
    }
}
