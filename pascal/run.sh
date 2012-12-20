#! /bin/bash

base=$(printf "pr%03d" $1)
shift

fpcopts=''
fpcopts="$fpcopts -g"
# fpcopts="$fpcopts -Co -CO -Cr"

fpc $fpcopts $base && (echo ''; ./$base)
rm -f $base $base.o
