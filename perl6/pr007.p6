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

class Sieve {
    has @!composites;

    submethod BUILD() {
        @!composites = self.fill(8192);
    }

    method is-prime(Int $n) {
        if $n > @!composites.elems {
            say "Resizing";
            my Int $size = @!composites.elems;
            while $size < $n {
                say "Resize $size";
                $size *= 8;
            }

            @!composites = self.fill($size);
        }

        return @!composites[$n];
    }

    method stats() {
        say "Size = {@!composites.elems}";
    }

    method next-prime(Int $n is copy) returns Int {
        return 3 if $n == 2;
        while True {
            $n += 2;
            return $n if self.is-prime($n);
        }
    }

    method fill(Int $size) {
        say "Filling to $size";
        my @composites = [0..$size].map({True});
        @composites[0] = False;
        @composites[1] = False;

        my Int $pos = 2;
        while $pos <= $size {
            if !@composites[$pos] {
                $pos += 2;
            } else {
                my Int $n = $pos + $pos;
                while $n <= $size {
                    @composites[$n] = False;
                    $n += $pos;
                }

                if $pos == 2 {
                    $pos += 1;
                } else {
                    $pos += 2;
                }
            }
        }

        say "Done filling";
        return @composites;
    }
}

my $sieve = Sieve.new();
my Int $n = 2;
my Int $count = 1;
while $count < 10001 {
    $count++;
    $n = $sieve.next-prime($n);
}
say $n;
$sieve.stats();
