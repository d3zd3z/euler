# Problem 10
#
# 08 February 2002
#
#
# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
#
# Find the sum of all the primes below two million.
#
# 142913828922

import sieve

var sv = InitSieve()
var total = 0
var p = 2
while p < 2_000_000:
  total += p
  p = sv.nextPrime(p)
echo(total)
