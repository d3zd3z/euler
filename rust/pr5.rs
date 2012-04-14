// Problem 5
// 
// 30 November 2001
// 
// 2520 is the smallest number that can be divided by each of the numbers
// from 1 to 10 without any remainder.
// 
// What is the smallest positive number that is evenly divisible by all of
// the numbers from 1 to 20?

use std;

fn main() {
    let accum = 1u;

    uint::range(2u, 20u) { |i|
        accum = lcm(accum, i);
    }
    std::io::println(#fmt("%u", accum));
}

fn lcm(a: uint, b: uint) -> uint {
    (a*b) / gcd(a, b)
}

/*
// Rustc doesn't appear to currently do TCO.
fn gcd(a: uint, b: uint) -> uint {
    if b == 0u { a }
    else { gcd(b, a % b) }
}
*/

fn gcd(a: uint, b: uint) -> uint {
    let ta = a;
    let tb = b;
    while tb != 0u {
        let tmp = ta % tb;
        ta = tb;
        tb = tmp;
    }
    ta
}
