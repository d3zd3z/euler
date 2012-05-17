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
open(I, "w3m -dump -cols 70 $URL|") or die;

open(O, ">pr$problem.adb") or die;

# Skip until we get the problem statement.
while (<I>) {
	last if /^Problem /;
}
print O <<EOF;
----------------------------------------------------------------------
--  $_
EOF
my $last = $_;
while (<I>) {
	last if /Project Euler Copyright/;
	if ($_ ne $last || !/^\s*\n/) {
		print O  "--  $_";
	}
	$last = $_;
}
my $upper = $problem;
$upper =~ s/\b(\w)/\U$1/g;
print O <<EOF;
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
--  with Euler; use Euler;

procedure Pr$upper is

begin
end Pr$upper;

EOF
close I or die "Problem getting euler page";
close O or die;
