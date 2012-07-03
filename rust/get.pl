#! /usr/bin/perl
#
# You have entered a maze of twisty passages, all alike.

use 5.008;
use strict;

die "Expecting an argument" unless $#ARGV == 0;
die "Expecting a single integer" unless $ARGV[0] =~ /([1-9][0-9]*)/;

my $problem = int($1);
$problem = sprintf("%03d", $problem);
# my $URL = "http://projecteuler.net/problem=$problem";
my $URL = "../haskell/probs/problem-$problem.html";
open(I, "w3m -dump -cols 75 $URL|") or die;

open(O, ">pr$problem.rs") or die;

# Skip until we get the problem statement.
while (<I>) {
	last if /^Problem /;
}
print O "// $_";
my $last = $_;
while (<I>) {
	last if /Project Euler Copyright/;
	chomp;
	if ($_ ne $last || !/^\s*\n/) {
		if (length) {
			print O  "// $_\n";
		} else {
			print O  "//\n";
		}
	}
	$last = $_;
}
print O <<EOF;

fn main() {
}
EOF
close I or die "Problem getting euler page";
close O or die;
