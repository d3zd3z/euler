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

const base: uint = 10_000;

fn main() {
    const size: uint = 40;
    let acc: ~[mut uint] = vec::to_mut(vec::from_elem(40, 0));

    acc[0] = 1;

    for uint::range(2, 101) |x| {
        multiply(acc, x);
    }
    let result = sum_digits(vec::from_mut(acc));
    io::println(fmt!("%u", result));
}

// Multiply the little-endian base 10_000 number in 'acc' by 'by'.
fn multiply(acc: &[mut uint], by: uint) {
    let mut carry = 0u;
    for acc.len().timesi() |i| {
        let temp = acc[i] * by + carry;
        acc[i] = temp % base;
        carry = temp / base;
    }
    if carry != 0 { fail ~"Multiply overflow" }
}

fn sum_digits(acc: &[uint]) -> uint {
    do acc.foldl(0u) |accum, n| {
        let mut sub = 0u;
        let mut tmp = *n;
        while tmp > 0 {
            sub += tmp % 10;
            tmp /= 10;
        }
        *accum + sub
    }
}
