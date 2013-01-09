// Problem 25
//
// 30 August 2002
//
//
// The Fibonacci sequence is defined by the recurrence relation:
//
//     F[n] = F[n−1] + F[n−2], where F[1] = 1 and F[2] = 1.
//
// Hence the first 12 terms will be:
//
//     F[1] = 1
//     F[2] = 1
//     F[3] = 2
//     F[4] = 3
//     F[5] = 5
//     F[6] = 8
//     F[7] = 13
//     F[8] = 21
//     F[9] = 34
//     F[10] = 55
//     F[11] = 89
//     F[12] = 144
//
// The 12th term, F[12], is the first term to contain three digits.
//
// What is the first term in the Fibonacci sequence to contain 1000 digits?
//
// 4782

const digits: uint = 999;

fn main() {
    let a = vec::to_mut(vec::from_elem(digits, 0_u8));
    let b = vec::to_mut(vec::from_elem(digits, 0_u8));

    a[0] = 1;
    b[0] = 1;
    let mut count = 3;

    let mut overflowed = false;
    loop {
        add(a, b, &mut overflowed);
        if overflowed { break; }
        count += 1;

        add(b, a, &mut overflowed);
        if overflowed { break; }
        count += 1;
    }
    io::println(fmt!("%u", count));
}

fn add(dest: &[mut u8], other: &[mut u8],
       overflowed: &mut bool)
{
    let mut carry = 0u8;
    for dest.len().timesi() |i| {
        let temp = dest[i] + other[i] + carry;
        dest[i] = temp % 10;
        carry = temp / 10;
    }

    *overflowed = carry != 0;
}
