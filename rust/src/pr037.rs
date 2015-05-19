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

define_problem!(pr037, 37, 748317);

fn pr037() -> u64 {
    let mut rights = right_truncatable_primes();
    rights.retain(|x| {is_left_truncatable(*x)});
    rights.retain(|x| {*x>9});
    rights.iter().fold(0, |a, x| {a + *x})
}

static RIGHT_DIGITS: &'static [u64] = &[1, 3, 7, 9];

// Given a list of numbers, return a list of the numbers that are
// still prime when a single digit is appended to the right.
fn add_primes(numbers: &[u64]) -> Vec<u64> {
    let mut result = vec![];
    for &number in numbers.iter() {
        for &extra in RIGHT_DIGITS.iter() {
            let n = number * 10 + extra;
            if is_prime(n) {
                result.push(n);
            }
        }
    }
    result
}

// Generate a list of all right-truncatable primes.
fn right_truncatable_primes() -> Vec<u64> {
    let mut result: Vec<u64> = vec![];
    let mut set = vec![2, 3, 5, 7];

    while set.len() > 0 {
        for &i in set.iter() {
            result.push(i);
        }
        set = add_primes(&set[..]);
    }
    result
}

// Is this number left truncatable?
fn is_left_truncatable(number: u64) -> bool {
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

fn is_prime(n: u64) -> bool {
    miller::is_prime(n, 20)
}
