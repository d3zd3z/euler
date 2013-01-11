#! /usr/bin/env coffee
#
# Problem 7
#
# 28 December 2001
#
# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
# that the 6th prime is 13.
#
# What is the 10 001st prime number?
#
# 104743

print = console.log

sieve = require './sieve.coffee'

euler007 = ->
  sv = new sieve.Sieve
  count = 1
  p = 2
  while count < 10000
    count++
    p = sv.nextPrime(p)
  p

print euler007()
