// Problem 33
//
// 20 December 2002
//
//
// The fraction ^49/[98] is a curious fraction, as an inexperienced
// mathematician in attempting to simplify it may incorrectly believe that ^
// 49/[98] = ^4/[8], which is correct, is obtained by cancelling the 9s.
//
// We shall consider fractions like, ^30/[50] = ^3/[5], to be trivial
// examples.
//
// There are exactly four non-trivial examples of this type of fraction, less
// than one in value, and containing two digits in the numerator and
// denominator.
//
// If the product of these four fractions is given in its lowest common
// terms, find the value of the denominator.
//
// 100

use num::rational::{Ratio, Rational};

define_problem!(main, 33);

fn main() {
    let mut total: Rational = Ratio::new(1, 1);
    for a in range(10u, 100) {
        for b in range(a + 1, 100) {
            if is_frac(a, b) {
                total = total * Ratio::new(a as int, b as int);
            }
        }
    }
    println!("{}", total.denom());
}

// Is this a/b valid in this situation?
fn is_frac(a: uint, b: uint) -> bool {
    let an = a / 10;
    let am = a % 10;
    let bn = b / 10;
    let bm = b % 10;
    (an == bm && bn > 0 && am*b == bn * a) ||
        (am == bn && bm > 0 && an*b == bm*a)
}
