#! /bin/sh

# Build a particularly named file, and run it.

file="$1"
shift
gfortran -fcheck=all -Wall -O3 -g "$file" && ./a.out "$@"

rm a.out
