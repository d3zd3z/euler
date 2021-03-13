// Problem 5
//
// 30 November 2001
//
// 2520 is the smallest number that can be divided by each of the numbers
// from 1 to 10 without any remainder.
//
// What is the smallest positive number that is evenly divisible by all of
// the numbers from 1 to 20?

// define_problem!(pr005, 5, 232792560);

const std = @import("std");
const misc = @import("misc.zig");
const assert = std.debug.assert;
const print = std.debug.print;

pub fn main() !void {
    var accum: u64 = 1;

    var i: u64 = 2;
    while (i <= 20) : (i += 1) {
        accum = misc.lcm(accum, i);
    }

    assert(accum == 232792560);
    print("5 {d}\n", .{accum});
}
