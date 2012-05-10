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
my $URL = "../haskell/probs/problem-$prob3.html";
open(I, "w3m -dump -cols 65 $URL|") or die;

open(O, ">Problem$prob3.scala") or die;
print O <<EOF;
/*
EOF

# Skip until we get the problem statement.
while (<I>) {
	last if /^Problem /;
}
print O " * $_";
my $last = $_;
while (<I>) {
	last if /Project Euler Copyright/;
	if ($_ ne $last || !/^\s*\n/) {
		chomp;
		my $line = " * $_";
		$line =~ s/\s+$//;
		print O  "$line\n";
	}
	$last = $_;
}
print O <<EOF;
 */

object Problem$prob3 extends App {
}
EOF
close I or die "Problem getting euler page";
close O or die;
