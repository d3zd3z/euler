#! /bin/sh

# TODO: Obviously, this should be written in P6.

name=problem$1.p6
URL="http://projecteuler.net/problem=$1"
cat <<ZED > $name
#! /usr/bin/perl6

use v6;

######################################################################
ZED
w3m -dump -cols 69 "$URL" |
	sed -e 's/^/# /' -e 's/ $//' >> $name
cat <<ZED >> $name
######################################################################

ZED
