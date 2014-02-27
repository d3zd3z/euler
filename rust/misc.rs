// Miscellaneous Euler utilities.

use std::num::zero;

#[allow(dead_code)]
pub fn is_palindrome<T: Num + Ord + Clone> (n: T, base: T) -> bool {
    n == reverse_number(n.clone(), base)
}

#[allow(dead_code)]
pub fn reverse_number<T: Num + Ord + Clone>(number: T, base: T) -> T {
    let z = zero();
    let mut n = number;
    let mut result: T = zero();
    while n > z {
        result = result * base + n % base;
        n = n / base;
    }
    result
}
