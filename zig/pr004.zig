// Problem 4
//
// 16 November 2001
//
// A palindromic number reads the same both ways. The largest palindrome made
// from the product of two 2-digit numbers is 9009 = 91 × 99.
//
// Find the largest palindrome made from the product of two 3-digit numbers.

// define_problem!(pr004, 4, 906609);

const std = @import("std");
const print = std.debug.print;
const assert = std.debug.assert;
const misc = @import("misc.zig");

pub fn main() !void {
    var max: usize = 0;
    var a: usize = 100;
    while (a < 1000) : (a += 1) {
        var b = a;
        while (b < 1000) : (b += 1) {
            const c = a * b;
            if (c > max and misc.is_palindrome(c, 10)) {
                max = c;
            }
        }
    }

    assert(max == 906609);
    print("4: {d}\n", .{max});
}
