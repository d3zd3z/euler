// Problem 3
//
// 02 November 2001
//
// The prime factors of 13195 are 5, 7, 13 and 29.
//
// What is the largest prime factor of the number 600851475143 ?
//
// 6857

const std = @import("std");
const print = std.debug.print;
const assert = std.debug.assert;
// define_problem!(pr003, 3, 6857);

pub fn main() !void {
    // First, the non-sieve solution.  This is usually faster than
    // building a whole sieve up.
    var number: u64 = 600851475143;
    var prime: u64 = 3;

    while (number > 1) {
        if (number % prime == 0) {
            number /= prime;
        } else {
            prime += 2;
        }
    }

    assert(prime == 6857);
    print("003: {d}\n", .{prime});

    // let mut sieve = Sieve::new();

    // let mut number = 600851475143u64;
    // let mut prime = 2;

    // while number > 1 {
    //     let p = prime as u64;
    //     if number % p == 0 {
    //         number /= p;
    //     } else {
    //         prime = sieve.next_prime(prime);
    //     }
    // }

    // prime
}
