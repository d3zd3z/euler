// Problem 6
//
// 14 December 2001
//
// The sum of the squares of the first ten natural numbers is,
//
// 1^2 + 2^2 + ... + 10^2 = 385
//
// The square of the sum of the first ten natural numbers is,
//
// (1 + 2 + ... + 10)^2 = 55^2 = 3025
//
// Hence the difference between the sum of the squares of the first ten
// natural numbers and the square of the sum is 3025 − 385 = 2640.
//
// Find the difference between the sum of the squares of the first one
// hundred natural numbers and the square of the sum.
// 25164150

const std = @import("std");
const misc = @import("misc.zig");
const assert = std.debug.assert;
const print = std.debug.print;

// define_problem!(pr006, 6, 25164150);

pub fn main() !void {
    var sum_sq: u64 = 0;
    var sum: u64 = 0;
    var i: u64 = 1;
    while (i < 101) : (i += 1) {
        sum += i;
        sum_sq += i * i;
    }

    const result = sum * sum - sum_sq;
    assert(result == 25164150);
    print("6: {d}\n", .{result});
}
