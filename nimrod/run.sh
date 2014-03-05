#! /bin/bash

base=$(printf "pr%03d" $1)
nimrod c --verbosity:0 ${NIMOPTS} $base.nim || exit 1
time ./$base
rm $base
