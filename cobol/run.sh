#! /bin/sh

# Slightly easier way to run them.

die()
{
	echo "$@"
	exit 1
}

problem=`printf "%03d" "$1"`

cobc -m euler-problem-$problem.cbl || die Compile error
cobcrun euler-problem-$problem
