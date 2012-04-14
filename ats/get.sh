#! /bin/sh

URL="http://projecteuler.net/problem=$1"
w3m -dump -cols 62 "$URL" |
	sed -e 's/^/ * /' -e 's/ $//' > pr$1.dats
