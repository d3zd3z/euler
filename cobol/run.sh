#! /bin/sh

# Slightly easier way to run them.

die()
{
	echo "$@"
	exit 1
}

problem=`printf "%03d" "$1"`

#export COB_CFLGAS="-fno-strict-aliasing -Wno-strict-aliasing --help"
#export COB_CC="echo"
cobc -Wall -O2 -m euler-problem-$problem.cbl || die Compile error
time cobcrun euler-problem-$problem
