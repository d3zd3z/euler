// A simple prime number sieve.

export t, make;
export is_prime;
export next_prime;

use std;
import std::bitv;

type t = bitv::bitv;

fn make(limit: uint) -> t {
    let result = bitv::bitv(limit + 1u, true);

    bitv::set(result, 0u, false);
    bitv::set(result, 1u, false);

    let mut pos = 2u;
    while pos <= limit {
        if !bitv::get(result, pos) {
            pos += 2u;
        } else {
            let mut n = pos + pos;
            while n <= limit {
                bitv::set(result, n, false);
                n += pos;
            }
            if pos == 2u {
                pos += 1u;
            } else {
                pos += 2u;
            }
        }
    }

    result
}

fn is_prime(&pv: t, n: uint) -> bool { bitv::get(pv, n) }

fn next_prime(&pv: t, n: uint) -> uint {

    if n == 2u {
        ret 3u;
    }

    let mut next = n + 2u;
    while !is_prime(pv, next) {
        next += 1u;
    }
    next
}
