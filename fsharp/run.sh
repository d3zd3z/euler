#! /bin/sh

# Modules to include
modules='sieve.fsi sieve.fs misc.fsi misc.fs'

# Fairly easy, at first.
target=$(printf "pr%03d" $1)
make $target.exe || exit 1
time mono $target.exe
# rm $target.exe
