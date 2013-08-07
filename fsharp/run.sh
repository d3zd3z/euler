#! /bin/sh

# Modules to include
modules='sieve.fsi sieve.fs misc.fsi misc.fs'

# This seems to work around a bug in my Mono 3.2.0 build.
MONO_OPTIONS=--optimize=-inline

# Fairly easy, at first.
target=$(printf "pr%03d" $1)
make $target.exe || exit 1
time mono $MONO_OPTIONS $target.exe
# rm $target.exe
