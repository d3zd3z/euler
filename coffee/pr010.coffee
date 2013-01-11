#! /usr/bin/env coffee
#
# Problem 10
#
# 08 February 2002
#
# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
#
# Find the sum of all the primes below two million.
#
# 142913828922

sieve = require './sieve.coffee'

euler010 = ->
  sv = new sieve.Sieve
  total = 0
  p = 2
  while p < 2000000
    total += p
    p = sv.nextPrime(p)
  total

console.log euler010()
