#! /usr/bin/perl6

use v6;

######################################################################
# Problem 5
#
# 30 November 2001
#
# 2520 is the smallest number that can be divided by each of the numbers
# from 1 to 10 without any remainder.
#
# What is the smallest positive number that is evenly divisible by all of
# the numbers from 1 to 20?
#
######################################################################
# 232792560

sub gcd(Int $a, Int $b) returns Int {
    if $b == 0 {
        return $a;
    } else {
        return gcd($b, $a % $b);
    }
}

sub lcm(Int $a, Int $b) returns Int {
    return ($a div gcd($a, $b)) * $b;
}

say [lcm] 1..20;
