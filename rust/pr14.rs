// Problem 14
// 
// 05 April 2002
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

use std;

fn main() {
    let cache = make_enum_cache();
    // let cache = make_uint_cache();

    let max_len = 0u;
    let max = 0u;
    uint::range(1u, 1_000_000u) {|x|
        let len = cache.chain_len(x);
        if len > max_len {
            max_len = len;
            max = x;
        }
    }
    std::io::println(#fmt("chain %u, len %u", max, max_len))
}

enum info {
    unknown,
    known(uint),
}

enum enum_cache = [mutable info];

iface scan {
    fn chain_len(n: uint) -> uint;
}

// This works, but is _very_ slow with Rust 0.1 (about 1/60 speed).
impl chain2_scan for scan {
    fn chain2(n: uint) -> uint {
        if n == 1u {
            ret 1u
        } else if n & 1u == 0u {
            ret 1u + self.chain_len(n >> 1u)
        } else {
            ret 1u + self.chain_len(3u * n + 1u)
        }
    }
}

// Instead, a generic function on the iface seems to be efficient.
fn chain2<T: scan>(ch: T, n: uint) -> uint {
    if n == 1u {
        ret 1u
    } else if n & 1u == 0u {
        ret 1u + ch.chain_len(n >> 1u)
    } else {
        ret 1u + ch.chain_len(3u * n + 1u)
    }
}

impl cache_ops of scan for enum_cache {
    fn chain_len(n: uint) -> uint {
        if n < vec::len(*self) {
            alt self[n] {
              unknown {
                // let answer = (self as scan).chain2(n);
                let answer = chain2(self, n);
                self[n] = known(answer);
                answer
              }
              known(x) { x }
            }
        } else {
            chain2(self, n)
        }
    }

    fn chain2(n: uint) -> uint {
        if n == 1u {
            ret 1u
        } else if n & 1u == 0u {
            ret 1u + self.chain_len(n >> 1u)
        } else {
            ret 1u + self.chain_len(3u * n + 1u)
        }
    }
}

fn make_enum_cache() -> scan {
    enum_cache(vec::init_elt_mut(unknown, 1000u)) as scan
}

/* Int-based cache, mostly to compare performance of ints and enums. */
enum uint_cache = [mutable uint];

fn make_uint_cache() -> scan {
    uint_cache(vec::init_elt_mut(0u, 1000u)) as scan
}

impl uint_cache_ops of scan for uint_cache {
    fn chain_len(n: uint) -> uint {
        if n < vec::len(*self) {
            let elt = self[n];
            if elt == 0u {
                let answer = self.chain2(n);
                self[n] = answer;
                answer
            } else {
                elt
            }
        } else {
            self.chain2(n)
        }
    }

    fn chain2(n: uint) -> uint {
        if n == 1u {
            ret 1u
        } else if n & 1u == 0u {
            ret 1u + self.chain_len(n >> 1u)
        } else {
            ret 1u + self.chain_len(3u * n + 1u)
        }
    }
}

/*
fn chain_len(&cache: cache, n: uint) -> uint {
    if n < vec::len(*cache) {
        alt cache[n] {
          unknown {
            let answer = chain2(cache, n);
            cache[n] = known(answer);
            answer
          }
          known(x) { x }
        }
    } else {
        chain2(cache, n)
    }
}

fn chain2(&cache: cache, n: uint) -> uint {
    if n == 1u {
        ret 1u
    } else if n&1u == 0u {
        ret 1u + chain_len(cache, n >> 1u)
    } else {
        ret 1u + chain_len(cache, 3u*n + 1u)
    }
}
*/
