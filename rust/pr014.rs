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

fn main() {
    let mut base = @Noncached;
    let mut l = base as @Lengther;
    // let l : Lengther = EnumCache() as Lengther;

    // TODO: Use a macro to show this, with nice information.
    /*
    println(fmt!("size: %?", sys::size_of::<Lengther>()));
    println(fmt!("size: %?", sys::size_of::<Lengther>()));
    println(fmt!("size: %?", sys::size_of::<EnumCache>()));
    println(fmt!("size: %?", sys::size_of::<Noncached>()));
    */
    compute_len(l);
}

trait Lengther {
    fn chain_len(@self, n: uint) -> uint;
}

fn compute_len(l: @Lengther) {
    let mut max_len = 0;
    let mut max = 0;
    for uint::range(1, 1_000_000) |x| {
        let len = l.chain_len(x);
        if len > max_len {
            max_len = len;
            max = x;
        }
    }
    println(fmt!("chain %?, len %?", max, max_len));
}

struct Noncached;

impl Lengther for Noncached {
    fn chain_len(@self, n: uint) -> uint {
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

enum Info {
    Unknown,
    Known(uint)
}

impl EnumCache {
    fn new() -> EnumCache {
        EnumCache { size: 1000,
            cache: vec::from_elem(1000, Unknown) }
    }
}

impl Lengther for EnumCache {
    fn chain_len(@self, n: uint) -> uint {
        if n < self.size {
            match self.cache[n] {
                Unknown => {
                    let mut mself = self;
                    let answer = self.chain2(n);
                    let cache = mself.cache;
                    cache[n] = Known(answer);
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
    fn chain2(@self, n: uint) -> uint {
        if n == 1 {
            1
        } else if n & 1 == 0 {
            1 + self.chain_len(n >> 1)
        } else {
            1 + self.chain_len(3 * n + 1)
        }
    }
}

/*

struct EnumCache {
    size: uint,
    cache: ~[mut Info]
}

fn EnumCache() -> EnumCache {
    EnumCache { size: 1000,
        cache: vec::to_mut(vec::from_elem(1000, Unknown)) }
}

impl EnumCache: Lengther {
    fn chain_len(n: uint) -> uint {
        if n < self.size {
            match self.cache[n] {
                Unknown => {
                    let answer = self.chain2(n);
                    self.cache[n] = Known(answer);
                    answer
                },
                Known(x) => x
            }
        } else {
            self.chain2(n)
        }
    }
}

impl EnumCache {
    fn chain2(n: uint) -> uint {
        if n == 1 {
            1
        } else if n & 1 == 0 {
            1 + self.chain_len(n >> 1)
        } else {
            1 + self.chain_len(3 * n + 1)
        }
    }
}

enum Info {
    Unknown,
    Known(uint)
}
*/

/*
// A cached solution that maintains a cache of values.

class enum_cache : lengther {
    let cache: ~[mut info];
    let size: uint;

    new() {
        self.size = 1000;
        self.cache = vec::to_mut(vec::from_elem(self.size, unknown));
    }

    fn chain_len(n: uint) -> uint {
        if n < self.size {
            alt self.cache[n] {
                unknown {
                    let answer = self.chain2(n);
                    self.cache[n] = known(answer);
                    answer
                }
                known(x) { x }
            }
        } else {
            self.chain2(n)
        }
    }

    fn chain2(n: uint) -> uint {
        if n == 1 {
            1
        } else if n & 1 == 0 {
            1 + self.chain_len(n >> 1)
        } else {
            1 + self.chain_len(3 * n + 1)
        }
    }
}

enum info {
    unknown,
    known(uint)
}
*/
