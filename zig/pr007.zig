// Problem 7
//
// 28 December 2001
//
// By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
// that the 6th prime is 13.
//
// What is the 10 001st prime number?
//
// 104743

// extern mod extra;

const std = @import("std");
const misc = @import("misc.zig");
const assert = std.debug.assert;
const print = std.debug.print;

const Sieve = @import("Sieve.zig");

pub fn main() !void {
    var alloc = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = alloc.deinit();
    var primes = try Sieve.init(&alloc.allocator);
    defer primes.deinit();
    var prime: usize = 2;
    var count: usize = 1;

    while (count < 10001) : (count += 1) {
        prime = try primes.nextPrime(prime);
    }

    assert(prime == 104743);
    print("7: {d}\n", .{prime});
}
