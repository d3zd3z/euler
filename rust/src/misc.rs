// Miscellaneous Euler utilities.

use num::Num;
use num::PrimInt;

use num::FromPrimitive;
use num::ToPrimitive;

#[allow(dead_code)]
pub fn is_palindrome<T: Num + Ord + Clone>(n: T, base: T) -> bool {
    n == reverse_number(n.clone(), base)
}

#[allow(dead_code)]
pub fn reverse_number<T: Num + Ord + Clone>(number: T, base: T) -> T {
    let z: T = T::zero();
    let mut n = number;
    let mut result: T = T::zero();
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
            }
            ch => {
                word.push(ch);
            }
        }
    }
    result.push(word);

    result
}

// Integer square root.  Returns the floor of the sqrt of n.
#[allow(clippy::many_single_char_names)]
pub fn isqrt<T: PrimInt + FromPrimitive + ToPrimitive>(n: T) -> T {
    let z = T::zero();
    let one = T::one();
    let two = one + one;

    if n == z {
        return z;
    }
    let tmp: T = FromPrimitive::from_u64(log2(n.to_u64().unwrap())).unwrap();
    let a = tmp / two;
    let b = tmp % two;
    let mut x = one << (a + b).to_usize().unwrap();
    loop {
        let y = (x + n / x) / two;
        if y >= x {
            return x;
        }
        x = y;
    }
}

// Return the floor log base 2 of this number, this is the number of
// bits needed to encode this value.
// TODO: Can we do this for a known size value?
fn log2(n: u64) -> u64 {
    if n == 0 {
        return 0;
    } // Needed, else it returns 64.

    let mut result = 64;
    let mut n = n;
    if n & 0xffffffff00000000 == 0 {
        result -= 32;
        n <<= 32;
    }
    if n & 0xffff000000000000 == 0 {
        result -= 16;
        n <<= 16;
    }
    if n & 0xff00000000000000 == 0 {
        result -= 8;
        n <<= 8;
    }
    if n & 0xf000000000000000 == 0 {
        result -= 4;
        n <<= 4;
    }
    if n & 0xc000000000000000 == 0 {
        result -= 2;
        n <<= 2;
    }
    if n & 0x8000000000000000 == 0 {
        result -= 1;
    }
    result
}

#[test]
fn test_isqrt() {
    assert!(log2(0) == 0);
    assert!(isqrt(10204 * 10204) == 10204);
    assert!(isqrt(65535u64 * 65535 - 1) == 65534);
    assert!(isqrt(65535u64 * 65535 + 1) == 65535);
}

// Get the individual digits of the number.  The result is reversed, since
// that is faster, and often quite useful in that form.
pub fn digits_of_rev(mut number: u64) -> Vec<u8> {
    let mut result = vec![];

    while number > 0 {
        result.push((number % 10) as u8);
        number /= 10;
    }

    if result.is_empty() {
        result.push(0);
    }

    result
}

// Convert a vector of digits back to a number.
pub fn of_digits(digits: &[u8]) -> u64 {
    let mut result = 0;

    for &digit in digits {
        result = result * 10 + digit as u64;
    }
    result
}
