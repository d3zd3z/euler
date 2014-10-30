// Problem 26
//
// 13 September 2002
//
//
// A unit fraction contains 1 in the numerator. The decimal representation of
// the unit fractions with denominators 2 to 10 are given:
//
//     ^1/[2]  =  0.5
//     ^1/[3]  =  0.(3)
//     ^1/[4]  =  0.25
//     ^1/[5]  =  0.2
//     ^1/[6]  =  0.1(6)
//     ^1/[7]  =  0.(142857)
//     ^1/[8]  =  0.125
//     ^1/[9]  =  0.(1)
//     ^1/[10] =  0.1
//
// Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can
// be seen that ^1/[7] has a 6-digit recurring cycle.
//
// Find the value of d < 1000 for which ^1/[d] contains the longest recurring
// cycle in its decimal fraction part.
//
// 983

use sieve::Sieve;

define_problem!(main, 26)

fn main() {
    let mut primes = Sieve::new();

    let mut p = 7;
    let mut largest = 0;
    let mut largest_value = 0;
    while p < 1000 {
        let size = tenlog(p);
        if size > largest {
            largest = size;
            largest_value = p;
        }
        p = primes.next_prime(p);
    }
    println!("{}", largest_value);
}

// For a given number n, the repeat length of 1/n is the solution to
// 'k' for 10**k = 1 (mod n)
// 'tenlog' solves this for a given value of 'n'.  For a composite
// number, the length will merely be the longest length of any of its
// factors, so there really isn't a need to test the composite values
// (although it doesn't hurt either).  However, the 'tenlog' function
// will fail to terminate if the value passed has 2 or 5 as factors,
// so this would have to be accounted for.

fn tenlog(n: uint) -> uint {
    let mut result = 1;
    let mut temp = 10 % n;

    while temp != 1 {
        result += 1;
        temp = (temp * 10) % n;
    }

    result
}
