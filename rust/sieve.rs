// A simple prime number sieve.

export t, make;
export is_prime;
export next_prime;

use std;
import std::bitv;

const default_size: uint = 8192u;

type t = @{ mut vec: bitv::bitv, mut limit: uint };

fn make() -> t {
    let result = @{mut vec: bitv::bitv(default_size + 1u, true),
        mut limit: default_size };

    fill(result);

    result
}

fn fill(pv: t) {
    // Assumes the vector is initialized to true.
    bitv::set(pv.vec, 0u, false);
    bitv::set(pv.vec, 1u, false);

    let mut pos = 2u;
    let limit = pv.limit;
    while pos <= limit {
        if !bitv::get(pv.vec, pos) {
            pos += 2u;
        } else {
            let mut n = pos + pos;
            while n <= limit {
                bitv::set(pv.vec, n, false);
                n += pos;
            }
            if pos == 2u {
                pos += 1u;
            } else {
                pos += 2u;
            }
        }
    }
}

fn is_prime(pv: t, n: uint) -> bool {
    if n >= pv.limit {
        let mut new_limit = pv.limit;
        while new_limit < n {
            new_limit *= 8u;
        }

        pv.vec = bitv::bitv(new_limit + 1u, true);
        pv.limit = new_limit;
        fill(pv);
    }

    ret bitv::get(pv.vec, n);
}

fn next_prime(pv: t, n: uint) -> uint {

    if n == 2u {
        ret 3u;
    }

    let mut next = n + 2u;
    while !is_prime(pv, next) {
        next += 1u;
    }
    next
}
