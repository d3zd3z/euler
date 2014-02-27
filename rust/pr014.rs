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

use std::vec;

// use std::mem;

fn main() {
    if false {
        let mut l = ~Noncached;
        compute_len(l);
    }
    if true {
        let mut l = ~EnumCache::new();
        compute_len(l);
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
    fn chain_len(&mut self, n: uint) -> uint {
        if n == 1 {
            1
        } else if n & 1 == 0 {
            1 + self.chain_len(n >> 1)
        } else {
            1 + self.chain_len(3 * n + 1)
        }
    }
}

/* Cached version, attempting to speed things up. */
struct EnumCache {
    size: uint,
    cache: ~[Info]
}

#[deriving(Clone, Eq)]
enum Info {
    Unknown,
    Known(uint)
}

impl EnumCache {
    fn new() -> EnumCache {
        let size = 100000;
        EnumCache { size: size,
            cache: vec::from_elem(size, Unknown) }
    }
}

impl Lengther for EnumCache {
    fn chain_len(&mut self, n: uint) -> uint {
        if n < self.size {
            match self.cache[n] {
                Unknown => {
                    let answer = self.chain2(n);
                    self.cache[n] = Known(answer);
                    answer
                }
                Known(x) => x
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
