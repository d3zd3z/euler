#! /bin/bash

base=$(printf "pr%03d" $1)
nim c --verbosity:0 ${NIMOPTS} $base.nim || exit 1
time ./$base
rm $base
