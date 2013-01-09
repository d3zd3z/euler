// Problem 12
//
// 08 March 2002
//
//
// The sequence of triangle numbers is generated by adding the natural
// numbers. So the 7^th triangle number would be 1 + 2 + 3 + 4 + 5 + 6 + 7 =
// 28. The first ten terms would be:
//
// 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
//
// Let us list the factors of the first seven triangle numbers:
//
//      1: 1
//      3: 1,3
//      6: 1,2,3,6
//     10: 1,2,5,10
//     15: 1,3,5,15
//     21: 1,3,7,21
//     28: 1,2,4,7,14,28
//
// We can see that 28 is the first triangle number to have over five
// divisors.
//
// What is the value of the first triangle number to have over five hundred
// divisors?
//
// 76576500

use io::println;
use sieve::*;

fn main() {
    let primes = Sieve();

    let mut n = 1u;
    let mut tri = 1u;
    loop {
        if divisor_count(&primes, tri) > 500u {
            break;
        }
        n += 1u;
        tri += n;
    }
    println(fmt!("%u", tri));
}

fn divisor_count(sieve: &Sieve, n: uint) -> uint {
    let mut result = 1u;
    let mut tmp = n;
    let mut prime = 2u;

    while tmp > 1u {
        let mut divide_count = 0u;
        while tmp % prime == 0u {
            tmp /= prime;
            divide_count += 1u;
        }

        result *= divide_count + 1u;

        if tmp > 1u {
            prime = sieve.next_prime(prime);
        }
    }

    return result
}
