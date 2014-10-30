// Problem 37
//
// 14 February 2003
//
//
// The number 3797 has an interesting property. Being prime itself, it is
// possible to continuously remove digits from left to right, and remain
// prime at each stage: 3797, 797, 97, and 7. Similarly we can work from
// right to left: 3797, 379, 37, and 3.
//
// Find the sum of the only eleven primes that are both truncatable from left
// to right and right to left.
//
// NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
//
// 748317

use miller;
use misc;

define_problem!(main, 37)

fn main() {
    let mut rights = right_truncatable_primes();
    rights.retain(|x| {is_left_truncatable(*x)});
    rights.retain(|x| {*x>9});
    let total = rights.iter().fold(0u, |a, x| {a + *x});
    println!("{}", total);
}

static right_digits: &'static [uint] = &[1u, 3, 7, 9];

// Given a list of numbers, return a list of the numbers that are
// still prime when a single digit is appended to the right.
fn add_primes(numbers: &[uint]) -> Vec<uint> {
    let mut result = vec![];
    for number in numbers.iter() {
        for extra in right_digits.iter() {
            let n = number * 10 + *extra;
            if is_prime(n) {
                result.push(n);
            }
        }
    }
    result
}

// Generate a list of all right-truncatable primes.
fn right_truncatable_primes() -> Vec<uint> {
    let mut result = vec![];
    let mut set = vec![2u, 3, 5, 7];

    while set.len() > 0 {
        result.push_all(set.as_slice());
        set = add_primes(set.as_slice());
    }
    result
}

// Is this number left truncatable?
fn is_left_truncatable(number: uint) -> bool {
    let mut number = number;
    while number > 0 {
        if number == 1 || !is_prime(number) {
            return false
        }

        let rev = misc::reverse_number(number, 10);
        number = misc::reverse_number(rev / 10, 10);
    }
    true
}

fn is_prime(n: uint) -> bool {
    miller::is_prime(n, 20)
}
