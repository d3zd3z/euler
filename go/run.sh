#! /bin/bash

# Run a single numeric target.
target=$(printf "pr%03d" $1)
make $target || exit 1
time ./$target
rm $target
