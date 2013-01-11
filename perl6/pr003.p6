#! /usr/bin/perl6

use v6;

######################################################################
# Problem 3
#
# 02 November 2001
#
# The prime factors of 13195 are 5, 7, 13 and 29.
#
# What is the largest prime factor of the number 600851475143 ?
#
######################################################################
# 6857

# We can easily do this without needing a prime sieve, since if we go
# in order, we'll only hit prime numbers.

my $num = 600851475143;
my $p = 3;  # Not divisible by 2.

while $num > 1 {
    while $num % $p == 0 {
        $num /= $p;
    }
    last if $num == 1;

    $p += 2;
}

say $p;
