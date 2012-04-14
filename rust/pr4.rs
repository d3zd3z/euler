// Problem 4
// 
// 16 November 2001
// 
// A palindromic number reads the same both ways. The largest palindrome made
// from the product of two 2-digit numbers is 9009 = 91 × 99.
// 
// Find the largest palindrome made from the product of two 3-digit numbers.

use std;

fn main() {
    let max = 0u;
    uint::range(100u, 1000u) { |a|
        uint::range(a, 1000u) { |b|
            let c = a * b;
            if c > max && is_palindrome(c) {
                max = c;
            }
        }
    }
    std::io::println(#fmt("%u", max));
}

fn is_palindrome(n: uint) -> bool {
    n == reverse_number(n)
}

fn reverse_number(number: uint) -> uint {
    let n = number;
    let result = 0u;
    while n > 0u {
        result = result * 10u + n % 10u;
        n /= 10u;
    }
    result
}
