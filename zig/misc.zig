// Misc utilities.

const assert = std.debug.assert;
const std = @import("std");

pub fn is_palindrome(num: anytype, base: @TypeOf(num)) bool {
    return num == reverse_number(num, base);
}

test "Palindromes" {
    assert(is_palindrome(123454321, 10));
    assert(!is_palindrome(123452321, 10));
}

pub fn reverse_number(num: anytype, base: @TypeOf(num)) @TypeOf(num) {
    var n = num;
    var result: @TypeOf(num) = 0;
    while (n > 0) {
        result = result * base + n % base;
        n /= base;
    }

    return result;
}

test "Reverse" {
    assert(reverse_number(12345, 10) == 54321);
}

pub fn lcm(a: anytype, b: @TypeOf(a)) @TypeOf(a) {
    return (a / gcd(a, b)) * b;
}

pub fn gcd(a: anytype, b: @TypeOf(a)) @TypeOf(a) {
    var aa = a;
    var bb = b;
    while (bb != 0) {
        const tmp = bb;
        bb = aa % bb;
        aa = tmp;
    }
    return aa;
}
