// If we list all the natural numbers below 10 that are multiples of
// 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
//
// Find the sum of all the multiples of 3 or 5 below 1000.
//
// 233168

const std = @import("std");

pub fn main() !void {
    var total: usize = 0;
    var i: usize = 1;
    while (i < 1000) : (i += 1) {
        if (i % 3 == 0 or i % 5 == 0) {
            total += i;
        }
    }
    std.log.info("total: {d}", .{total});
}
