#! /bin/sh

URL="http://projecteuler.net/problem=$1"
echo '----------------------------------------------------------------------' > pr$1.hs
w3m -dump -cols 69 "$URL" |
	sed -e 's/^/-- /' -e 's/ $//' >> pr$1.hs
echo '----------------------------------------------------------------------' >> pr$1.hs