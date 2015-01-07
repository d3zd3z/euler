// Miscellaneous Euler utilities.

use std::num::Int;

#[allow(dead_code)]
pub fn is_palindrome<T: Int + Ord + Clone> (n: T, base: T) -> bool {
    n == reverse_number(n.clone(), base)
}

#[allow(dead_code)]
pub fn reverse_number<T: Int + Ord + Clone>(number: T, base: T) -> T {
    let z: T = Int::zero();
    let mut n = number;
    let mut result: T = Int::zero();
    while n.clone() > z {
        result = result * base.clone() + n.clone() % base.clone();
        n = n / base.clone();
    }
    result
}

/// Several problems contain a single line of comma separated quoted
/// strings.  Decode that all at once.
#[allow(dead_code)]
pub fn decode_words(line: &str) -> Vec<String> {
    let mut result = Vec::new();
    let mut word = String::new();

    for ch in line.chars() {
        match ch {
            '"' => (),
            ',' => {
                result.push(word);
                word = String::new();
            },
            ch => {
                word.push(ch);
            }
        }
    }
    result.push(word);

    result
}

// Integer square root.  Returns the floor of the sqrt of n.
#[allow(dead_code)]
pub fn isqrt(n: uint) -> uint {
    if n == 0 {
        return 0;
    }
    let tmp = log2(n as u64);
    let a = tmp / 2;
    let b = tmp % 2;
    let mut x = 1u << (a+b);
    loop {
        let y = (x + n / x) / 2;
        if y >= x {
            return x;
        }
        x = y;
    }
}

// Return the floor log base 2 of this number, this is the number of
// bits needed to encode this value.
// TODO: Can we do this for a known size value?
fn log2(n: u64) -> uint {
    if n == 0 { return 0; } // Needed, else it returns 64.

    let mut result = 64;
    let mut n = n;
    if n & 0xffffffff00000000 == 0 { result -= 32; n <<= 32; }
    if n & 0xffff000000000000 == 0 { result -= 16; n <<= 16; }
    if n & 0xff00000000000000 == 0 { result -=  8; n <<=  8; }
    if n & 0xf000000000000000 == 0 { result -=  4; n <<=  4; }
    if n & 0xc000000000000000 == 0 { result -=  2; n <<=  2; }
    if n & 0x8000000000000000 == 0 { result -=  1; }
    result
}

#[test]
fn test_isqrt() {
    assert!(log2(0) == 0);
    assert!(isqrt(10204 * 10204) == 10204);
    assert!(isqrt(65535 * 65535 - 1) == 65534);
    assert!(isqrt(65535 * 65535 + 1) == 65535);
}
