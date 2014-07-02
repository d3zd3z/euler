// Problem 16
//
// 03 May 2002
//
//
// 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
//
// What is the sum of the digits of the number 2^1000?
//
//
// 1366

define_problem!(main, 16)

fn main() {
    static size: uint = 302;
    let mut digits = Vec::from_elem(size, 0u8);
    *digits.get_mut(0) = 1;
 
    for _x in range(0u, 1000) {
        double(digits.as_mut_slice());
    }

    let result = digits.iter().fold(0u, |accum, n| {
        accum + *n as uint
    });
    println!("{}", result);
}

fn double(digits: &mut [u8]) {
    let mut carry = 0;
    for i in range(0u, digits.len()) {
        let temp = digits[i] * 2 + carry;
        digits[i] = temp % 10;
        carry = temp / 10;
    }

    if carry != 0 { fail!("Numeric overflow"); }
}
