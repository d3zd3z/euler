#! /bin/bash

# Run a rust problem.

if false; then
	if [ -x /usr/local/rust/bin/rustc ]; then
		RUST=/usr/local/rust/bin/rustc
	else
		echo 'Unable to find dev rust build'
		exit 1
	fi
else
	RUST=rustc
fi

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

$RUST -O $src && time ./$base
rm ./$base
