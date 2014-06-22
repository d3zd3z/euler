// Problem 30
//
// 08 November 2002
//
//
// Surprisingly there are only three numbers that can be written as the sum
// of fourth powers of their digits:
//
//     1634 = 1^4 + 6^4 + 3^4 + 4^4
//     8208 = 8^4 + 2^4 + 0^4 + 8^4
//     9474 = 9^4 + 4^4 + 7^4 + 4^4
//
// As 1 = 1^4 is not a sum it is not included.
//
// The sum of these numbers is 1634 + 8208 + 9474 = 19316.
//
// Find the sum of all the numbers that can be written as the sum of fifth
// powers of their digits.
// 443839

// Looking at n*9^5, we can quickly determine that there cannot be a
// 7-digit number that works.  Se, only need to compute up to n=6.

fn main() {
    let mut result = 0;
    for x in range(2u, 354295) {
        if sum_power(x, 5) == x {
            result += x;
        }
    }

    println!("{}", result);
}

fn sum_power(x: uint, pow: uint) -> uint {
    let mut result = 0;
    let mut tmp = x;
    while tmp > 0 {
        let digit = tmp % 10;
        tmp /= 10;
        result += simple_pow(digit, pow);
    }
    result
}

fn simple_pow(x: uint, pow: uint) -> uint {
    let mut result = 1;
    for _ in range(0, pow) {
        result *= x;
    }
    result
}
