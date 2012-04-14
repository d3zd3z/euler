#! /bin/bash

file=$(printf "problem-%03d.html" $1)
wget -O $file http://projecteuler.net/problem=$1
