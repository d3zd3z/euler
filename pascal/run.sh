#! /bin/bash

base=$(printf "pr%03d" $1)
shift

fpc $base && ./$base
rm -f $base $base.o
