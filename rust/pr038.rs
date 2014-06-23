// Problem 38
//
// 28 February 2003
//
//
// Take the number 192 and multiply it by each of 1, 2, and 3:
//
//     192 x 1 = 192
//     192 x 2 = 384
//     192 x 3 = 576
//
// By concatenating each product we get the 1 to 9 pandigital, 192384576. We
// will call 192384576 the concatenated product of 192 and (1,2,3)
//
// The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4,
// and 5, giving the pandigital, 918273645, which is the concatenated product
// of 9 and (1,2,3,4,5).
//
// What is the largest 1 to 9 pandigital 9-digit number that can be formed as
// the concatenated product of an integer with (1,2, ... , n) where n > 1?
//
// 932718654

fn main() {
    let mut largest = 0u64;
    for i in range(1u, 10000) {
        let sum = large_sum(i);
        if sum > largest && is_pandigital(sum) {
            largest = sum;
        }
    }
    println!("{}", largest);
}

// Given a 'base' according to the problem, multiple successively by
// the digits starting with 1 until we reach >= 9 digits.
fn large_sum(base: uint) -> u64 {
    let base = base as u64;
    let mut result = 0u64;
    let mut x = 1u64;
    while result < 100_000_000 {
        result = concatenate(result, base * x);
        x += 1;
    }
    result
}

// Is this number a full 9-element pandigital number.
// Compute this by collecting each digit, and tracking them as bits in
// a value, making sure no bits are set twice, and at the end that all
// of the desired bits are set.
fn is_pandigital(number: u64) -> bool {
    let mut bits = 0;
    let mut number = number;

    while number > 0 {
        let m = number % 10;
        let bit = 1 << m;
        if (bits & bit) != 0 {
            return false;
        }
        bits |= bit;
        number /= 10;
    }
    bits == 1022  // 1-9 without the zero.
}

#[test]
fn test_is_pandigital() {
    assert!(is_pandigital(192384576));
    assert!(!is_pandigital(1923845767));
    assert!(!is_pandigital(19238476));
}

// Concatenate the two numbers in decimal.
fn concatenate(a: u64, b: u64) -> u64 {
    let mut result = a;
    let mut tmp = b;
    while tmp > 0 {
        result *= 10;
        tmp /= 10;
    }
    result + b
}

#[test]
fn test_concatenate() {
    assert_eq!(concatenate(123, 456), 123456);
    assert_eq!(concatenate(0, 789), 789);
    assert_eq!(concatenate(456, 0), 456);
}
