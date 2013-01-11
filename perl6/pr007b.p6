#! /usr/bin/perl6

use v6;

######################################################################
# Problem 7
#
# 28 December 2001
#
# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
# that the 6th prime is 13.
#
# What is the 10 001st prime number?
#
######################################################################
# 104743

# It appears that Perl6 already defines an 'is-prime' function, which
# an error below was happy to just call.

sub next-prime(Int $n is copy) returns Int {
    return 3 if $n == 2;
    while True {
        $n += 2;
        return $n if is-prime($n);
    }
}

my Int $n = 2;
my Int $count = 1;
while $count < 10001 {
    $count++;
    $n = next-prime($n);
}
say $n;
