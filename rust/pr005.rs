// Problem 5
// 
// 30 November 2001
// 
// 2520 is the smallest number that can be divided by each of the numbers
// from 1 to 10 without any remainder.
// 
// What is the smallest positive number that is evenly divisible by all of
// the numbers from 1 to 20?

extern crate num;
use num::Integer;

fn main() {
    let mut accum = 1u;

    for i in range(2u, 20) {
        accum = accum.lcm(&i);
        // accum = accum.lcm(&i);
        // accum = lcm(accum, i);
    }
    println!("{}", accum);
}
