#! /usr/bin/perl
#
# You have entered a maze of twisty passages, all alike.

use 5.008;
use strict;

die "Expecting an argument" unless $#ARGV == 0;
die "Expecting a single integer" unless $ARGV[0] =~ /([1-9][0-9]*)/;

my $problem = int($1);
$problem = sprintf("%03d", $problem);
my $prob3 = $problem;
# my $URL = "http://projecteuler.net/problem=$problem";
my $URL = "../haskell/probs/problem-$prob3.html";
open(I, "w3m -dump -cols 64 $URL|") or die;

open(O, ">euler-problem-$problem.cbl") or die;

# Skip until we get the problem statement.
while (<I>) {
	last if /^Problem /;
}
print O <<EOF;
      * $_
EOF
my $last = $_;
while (<I>) {
	last if /Project Euler Copyright/;
	chomp;
	if ($_ ne $last || !/^\s*\n/) {
		if (length) {
			print O  "      * $_\n";
		} else {
			print O  "      *\n";
		}
	}
	$last = $_;
}
my $upper = $problem;
$upper =~ s/\b(\w)/\U$1/g;
print O <<EOF;
      *
       identification division.
       program-id. euler-problem-$problem.

       data division.
       working-storage section.

       procedure division.

           stop run.
EOF
close I or die "Problem getting euler page";
close O or die;
