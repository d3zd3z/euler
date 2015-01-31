// Problem 36
//
// 31 January 2003
//
//
// The decimal number, 585 = 1001001001[2] (binary), is palindromic in both
// bases.
//
// Find the sum of all numbers, less than one million, which are palindromic
// in base 10 and base 2.
//
// (Please note that the palindromic number, in either base, may not include
// leading zeros.)
//
// 872187

use misc;

define_problem!(pr036, 36, 872187);

fn pr036() -> uint {
    let mut total = 0;
    for i in 1u .. 1_000_000 {
        if misc::is_palindrome(i, 10) && misc::is_palindrome(i, 2) {
            total += i;
        }
    }

    total
}
