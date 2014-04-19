#! /bin/sh

base=$(printf "pr%03d" $1)
shift

rock $base && time ./$base
rm ./$base
