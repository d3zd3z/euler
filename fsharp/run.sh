#! /bin/sh

# Modules to include
modules='sieve.fsi sieve.fs misc.fsi misc.fs'

# Fairly easy, at first.
target=$(printf "pr%03d" $1)
fsharpc --nologo $modules $target.fs || exit 1
time mono $target.exe
rm $target.exe
