#! /bin/bash

base=$(printf "pr%03d" $1)
shift

mmcopts=''
mmcopts="$mmcopts --make"

mmc $mmcopts $base && (echo ''; ./$base)
rm -f $base $base.err $base.mh
