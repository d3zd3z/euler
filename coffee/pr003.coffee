#! /usr/bin/env coffee
#
# Problem 3
#
# 02 November 2001
#
# The prime factors of 13195 are 5, 7, 13 and 29.
#
# What is the largest prime factor of the number 600851475143 ?
#
# 6857

euler003 = ->
  n = 600851475143
  p = 2
  while n > 1
    if (n % p) == 0
      n /= p
    else
      p = if p == 2 then 3 else p + 2
  p

console.log (euler003())
