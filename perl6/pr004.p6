#! /usr/bin/perl6

use v6;

######################################################################
# Problem 4
#
# 16 November 2001
#
# A palindromic number reads the same both ways. The largest palindrome made
# from the product of two 2-digit numbers is 9009 = 91 x 99.
#
# Find the largest palindrome made from the product of two 3-digit numbers.
#
######################################################################
# 906609

sub reverse-number(Int $number is copy --> Int) {
    my Int $result = 0;
    while $number > 0 {
        $result = $result * 10 + $number % 10;
        $number div= 10;
    }
    return $result;
}

sub is-palindrome(Int $number --> Bool) {
    return $number == reverse-number($number);
}

my $max = 0;
for 100..999 -> Int $a {
    for $a..999 -> Int $b {
        my Int $c = $a * $b;
        # say $a, ' ', $b, ' ', $c;
        $max = $c if $c > $max && is-palindrome($c);
    }
}

say $max;
