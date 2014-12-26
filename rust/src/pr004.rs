// Problem 4
//
// 16 November 2001
//
// A palindromic number reads the same both ways. The largest palindrome made
// from the product of two 2-digit numbers is 9009 = 91 × 99.
//
// Find the largest palindrome made from the product of two 3-digit numbers.

use misc;

define_problem!(main, 4);

fn main() {
    let mut max = 0u;
    for a in range(100u, 1000) {
        for b in range(a, 1000) {
            let c = a * b;
            if c > max && misc::is_palindrome(c, 10) {
                max = c;
            }
        }
    }
    println!("{}", max);
}
