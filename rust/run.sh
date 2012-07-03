#! /bin/bash

# Run a rust problem.

base=$(printf "pr%03d" $1)
shift

if [ -f $base.rc ]; then
	src=$base.rc
elif [ -f $base.rs ]; then
	src=$base.rs
else
	echo "Unknown problem '$base'"
	exit 1
fi

rustc $src && ./$base
rm ./$base
