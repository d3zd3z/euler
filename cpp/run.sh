#! /bin/bash

base=$(printf "pr%03d" $1)
shift

cppopts=''
cppopts="$fpcopts -g"

g++ $cppopts -o $base $base.cpp sieve.cpp && ./$base
rm -f $base $base.o
