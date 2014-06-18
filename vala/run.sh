#! /bin/bash

base=$(printf "pr%03d" $1)
shift

make ${base} && ./${base}
rm -f ${base}
