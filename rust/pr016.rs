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

fn main() {
    const size: uint = 302u;
    let digits: [mut u8] = vec::to_mut(vec::from_elem(size, 0u8));
    digits[0] = 1u8;

    uint::range(0u, 1000u) {|_x|
        double(digits);
    }
    /*
    uint::range(0u, size) {|i|
        io::print(#fmt("%u", digits[size-i-1u] as uint));
    }
    io::println("");
    */

    let result = vec::foldl(0u, digits) {|accum, n|
        accum + n as uint
    };
    io::println(#fmt("%u", result));
}

fn double(digits: [mut u8]) {
    let mut carry = 0u8;
    vec::iteri(digits) {|i, value|
        let temp = value * 2u8 + carry;
        digits[i] = temp % 10u8;
        carry = temp / 10u8;
    }

    if carry != 0u8 { fail "Numeric overflow"; }
}
