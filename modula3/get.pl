#! /usr/bin/perl
#
# You have entered a maze of twisty passages, all alike.

use 5.008;
use strict;

die "Expecting an argument" unless $#ARGV == 0;
die "Expecting a single integer" unless $ARGV[0] =~ /([1-9][0-9]*)/;

my $problem = int($1);
my $prob3 = sprintf("%03d", $problem);
# my $URL = "http://projecteuler.net/problem=$problem";
my $URL = sprintf("../haskell/probs/problem-%03d.html", $problem);
open(I, "w3m -dump -cols 75 $URL|") or die;

open(O, ">Pr$prob3.m3") or die;

# Skip until we get the problem statement.
while (<I>) {
	last if /^Problem /;
}
print O "(*\n";
print O " * $_";
my $last = $_;
while (<I>) {
    last if /Project Euler Copyright/;
    if ($_ ne $last || !/^\s*\n/) {
	if (length($_) > 1) {
	    print O  " * $_";
	} else {
	    print O " *\n";
	}
    }
    $last = $_;
}
print O <<EOF;
 *)

MODULE Pr$prob3;

IMPORT Fmt;
IMPORT IO;

PROCEDURE Run() =
  BEGIN
    IO.Put(Fmt.Int(0) & "\\n");
  END Run;

BEGIN
END Pr$prob3.
EOF
close I or die "Problem getting euler page";
close O or die;
