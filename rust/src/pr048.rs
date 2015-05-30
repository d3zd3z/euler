// Problem 48
//
// 18 July 2003
//
//
// The series, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.
//
// Find the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000^1000.

define_problem!(pr048, 48, 9110846700);

const MODULUS: u64 = 10000000000;

fn pr048() -> u64 {
    let mut sum = 0;
    for i in 1 .. 1001 {
        sum = (sum + expt(i, i)) % MODULUS;
    }

    sum
}

fn expt(base: u64, power: u64) -> u64 {
    let mut result = 1;
    for _ in 0 .. power {
        result = (result * base) % MODULUS;
    }
    result
}
