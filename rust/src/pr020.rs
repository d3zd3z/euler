// Problem 20
//
// 21 June 2002
//
//
// n! means n x (n − 1) x ... x 3 x 2 x 1
//
// For example, 10! = 10 x 9 x ... x 3 x 2 x 1 = 3628800,
// and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 =
// 27.
//
// Find the sum of the digits in the number 100!
//
// 648

// This is easier to do by using something like base 10_000 (100**2).

define_problem!(main, 20)

static base: uint = 10_000;

fn main() {
    static size: uint = 40;
    // let mut acc: [uint, .. size] = [0u, .. size];
    let mut acc = Vec::from_elem(size, 0u);

    acc[0] = 1;

    for x in range(2u, 101) {
        multiply(acc.as_mut_slice(), x);
    }
    let result = sum_digits(acc.as_slice());
    println!("{}", result);
}

// Multiply the little-endian base 10_000 number in 'acc' by 'by'.
fn multiply(acc: &mut [uint], by: uint) {
    let mut carry = 0u;
    for i in range(0u, acc.len()) {
        let temp = acc[i] * by + carry;
        acc[i] = temp % base;
        carry = temp / base;
    }
    if carry != 0 { panic!("Multiply overflow") }
}

fn sum_digits(acc: &[uint]) -> uint {
    acc.iter().fold(0u, |accum, n| {
        let mut sub = 0u;
        let mut tmp = *n;
        while tmp > 0 {
            sub += tmp % 10;
            tmp /= 10;
        }
        accum + sub
    })
}