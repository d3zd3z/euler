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
    // Looks like we can't make this generic yet.
    // let l = @enum_cache() as lengther;

    // naive();
    cached();
}

iface lengther {
    fn chain_len(n: uint) -> uint;
}

// Simple solution that computes it by brute force.
fn naive() {
    let mut max_len = 0u;
    let mut max = 0u;
    uint::range(1u, 1_000_000u) {|x|
        let len = simple_chain_len(x);
        if len > max_len {
            max_len = len;
            max = x;
        }
    }
    io::println(#fmt("chain %u, len %u", max, max_len));
}

fn cached() {
    let mut max_len = 0u;
    let mut max = 0u;
    let cache = enum_cache();
    uint::range(1u, 1_000_000u) {|x|
        let len = cache.chain_len(x);
        if len > max_len {
            max_len = len;
            max = x;
        }
    }
    io::println(#fmt("chain %u, len %u", max, max_len));
}

fn simple_chain_len(n: uint) -> uint {
    if n == 1u {
        ret 1u
    } else if n & 1u == 0u {
        ret 1u + simple_chain_len(n >> 1u)
    } else {
        ret 1u + simple_chain_len(3u * n + 1u)
    }
}

// A cached solution that maintains a cache of values.

class enum_cache {
    let cache: @[mut info];
    let size: uint;

    new() {
        size = 1000u;
        cache = @vec::to_mut(vec::from_elem(size, unknown));
    }

    fn chain_len(n: uint) -> uint {
        if n < size {
            alt cache[n] {
                unknown {
                    let answer = chain2(n);
                    cache[n] = known(answer);
                    answer
                }
                known(x) { x }
            }
        } else {
            chain2(n)
        }
    }

    fn chain2(n: uint) -> uint {
        if n == 1u {
            1u
        } else if n & 1u == 0u {
            1u + chain_len(n >> 1u)
        } else {
            1u + chain_len(3u * n + 1u)
        }
    }
}

enum info {
    unknown,
    known(uint)
}
