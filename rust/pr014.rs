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
    // let l : lengther = noncached as lengther;
    let l : lengther = enum_cache() as lengther;

    // io::println(#fmt("size: %?", sys::size_of::<info>()));
    // io::println(#fmt("size: %?", sys::size_of::<lengther>()));
    // io::println(#fmt("size: %?", sys::size_of::<enum_cache>()));
    // io::println(#fmt("size: %?", sys::size_of::<noncached>()));
    compute_len(l);
}

iface lengther {
    fn chain_len(n: uint) -> uint;
}

enum noncached { noncached }

impl of lengther for noncached {
    fn chain_len(n: uint) -> uint {
        simple_chain_len(n)
    }
}

fn compute_len(l: lengther) {
    let mut max_len = 0;
    let mut max = 0;
    for uint::range(1, 1_000_000) |x| {
        let len = l.chain_len(x);
        if len > max_len {
            max_len = len;
            max = x;
        }
    }
    io::println(#fmt("chain %?, len %?", max, max_len));
}

fn simple_chain_len(n: uint) -> uint {
    if n == 1 {
        ret 1
    } else if n & 1 == 0 {
        ret 1 + simple_chain_len(n >> 1)
    } else {
        ret 1 + simple_chain_len(3 * n + 1)
    }
}

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
