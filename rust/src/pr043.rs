// Problem 43
//
// 09 May 2003
//
//
// The number, 1406357289, is a 0 to 9 pandigital number because it is made
// up of each of the digits 0 to 9 in some order, but it also has a rather
// interesting sub-string divisibility property.
//
// Let d[1] be the 1^st digit, d[2] be the 2^nd digit, and so on. In this
// way, we note the following:
//
//   • d[2]d[3]d[4]=406 is divisible by 2
//   • d[3]d[4]d[5]=063 is divisible by 3
//   • d[4]d[5]d[6]=635 is divisible by 5
//   • d[5]d[6]d[7]=357 is divisible by 7
//   • d[6]d[7]d[8]=572 is divisible by 11
//   • d[7]d[8]d[9]=728 is divisible by 13
//   • d[8]d[9]d[10]=289 is divisible by 17
//
// Find the sum of all 0 to 9 pandigital numbers with this property.

use permute::next_permutation;

define_problem!(pr043, 43, 16695334890);

fn pr043() -> u64 {
    let mut work: Vec<u8> = (0_u8 .. 10).collect();
    let mut done = false;
    let mut total = 0u64;

    loop {
        if check(&work[]) {
            total += digits_value(&work[]);
        }

        next_permutation(&mut work[], &mut done);
        if done { break; }
    }

    total
}

// Check the given number if it obeys the interesting property.
fn check(v: &[u8]) -> bool {
    fn piece(v: &[u8], start: usize) -> u32 {
        (v[start] as u32 * 100 +
         v[start+1] as u32 * 10 +
         v[start+2] as u32)
    }

    EARLY_PRIMES.iter().enumerate().all(|(i, &n)| {
        // println!("i = {}, n = {}, piece={}", i, n, piece(v, i+1));
        piece(v, i+1) % n == 0
    })
}

// Build the number out of the vector of digits.
fn digits_value(v: &[u8]) -> u64 {
    v.iter().fold(0u64, |a, &b| a * 10 + b as u64)
}

static EARLY_PRIMES: &'static [u32] = &[
    2, 3, 5, 7, 11, 13, 17
];
