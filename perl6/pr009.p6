#! /usr/bin/perl6

use v6;

######################################################################
# Problem 9
#
# 25 January 2002
#
# A Pythagorean triplet is a set of three natural numbers, a < b < c, for
# which,
#
# a^2 + b^2 = c^2
#
# For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
#
# There exists exactly one Pythagorean triplet for which a + b + c = 1000.
# Find the product abc.
#
######################################################################
# 31875000

for 1..999 -> $a {
    for $a..999 -> $b {
        my $c = 1000 - $a - $b;
        say $a*$b*$c if $c > $b && $a*$a + $b*$b == $c*$c;
    }
}
