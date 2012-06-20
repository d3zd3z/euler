#! /bin/sh

# Build a particularly named file, and run it.

gfortran -fcheck=all -Wall -O3 -g "$1" && ./a.out

rm a.out
