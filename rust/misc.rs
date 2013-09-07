// Miscellaneous Euler utilities.

use std::num::zero;

pub fn is_palindrome<T: Num + Ord + Clone> (n: T, base: T) -> bool {
    n == reverse_number(n.clone(), base)
}

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
