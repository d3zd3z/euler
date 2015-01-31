// Problem 5
// 
// 30 November 2001
// 
// 2520 is the smallest number that can be divided by each of the numbers
// from 1 to 10 without any remainder.
// 
// What is the smallest positive number that is evenly divisible by all of
// the numbers from 1 to 20?

use num::Integer;

define_problem!(pr005, 5, 232792560);

fn pr005() -> uint {
    let mut accum = 1u;

    for i in (2u .. 20) {
        accum = accum.lcm(&i);
        // accum = accum.lcm(&i);
        // accum = lcm(accum, i);
    }
    accum
}
