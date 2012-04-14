#! /usr/bin/perl6

use v6;

######################################################################
# Problem 1
#
# 05 October 2001
#
#
# If we list all the natural numbers below 10 that are multiples of 3
# or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
#
# Find the sum of all the multiples of 3 or 5 below 1000.
######################################################################

say 'computing';
my $sum = 0;
for 1..1000 -> $i {
    $sum += $i if $i % 5 == 0 || $i % 3 == 0;
}
say $sum;
