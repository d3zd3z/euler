//! A prime sieve.

const std = @import("std");
const Allocator = std.mem.Allocator;
const DEFAULT_SIZE: usize = 8192;

const Self = @This();

const BoolArray = std.ArrayList(bool);

vec: BoolArray,

pub fn init(allocator: *Allocator) !Self {
    const vec = try BoolArray.initCapacity(allocator, DEFAULT_SIZE);
    var result = Self{
        .vec = vec,
    };
    result.fill();
    return result;
}

pub fn isPrime(self: *Self, n: usize) !bool {
    if (n >= self.vec.items.len) {
        var new_limit = self.vec.items.len;
        while (new_limit < n) : (new_limit *= 8) {}
        try self.vec.ensureCapacity(new_limit);
        self.fill();
    }

    return self.vec.items[n];
}

pub fn nextPrime(self: *Self, n: usize) !usize {
    if (n == 2) {
        return 3;
    }

    var next = n + 2;
    while (!try self.isPrime(next)) {
        next += 2;
    }
    return next;
}

fn fill(self: *Self) void {
    const limit = self.vec.capacity;
    self.vec.items.len = limit;

    self.vec.items[0] = false;
    self.vec.items[1] = false;
    var i: usize = 2;
    while (i < limit) : (i += 1) {
        self.vec.items[i] = true;
    }

    var pos: usize = 2;
    while (pos < limit) {
        if (!self.vec.items[pos]) {
            pos += 2;
        } else {
            var n = pos + pos;
            while (n < limit) : (n += pos) {
                self.vec.items[n] = false;
            }
            if (pos == 2) {
                pos += 1;
            } else {
                pos += 2;
            }
        }
    }
}

pub fn deinit(self: Self) void {
    self.vec.deinit();
}

test "Sieve" {
    var sieve = try Self.init(std.testing.allocator);
    defer sieve.deinit();

    // var i: usize = 1;
    // while (i < sieve.vec.items.len) : (i += 1) {
    //     if (sieve.vec.items[i]) {
    //         std.debug.print(" {d}", .{i});
    //     }
    // }
    // std.debug.print("\n", .{});
}

test "failure" {
    var alloc = std.testing.FailingAllocator.init(std.testing.allocator, 1);
    var sieve = try Self.init(&alloc.allocator);
    defer sieve.deinit();
}

test "Leak test" {
    var sieve = try Self.init(std.testing.allocator);
    defer sieve.deinit();
}
