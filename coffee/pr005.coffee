#! /usr/bin/env coffee
#
# Problem 5
#
# 30 November 2001
#
# 2520 is the smallest number that can be divided by each of the numbers
# from 1 to 10 without any remainder.
#
# What is the smallest positive number that is evenly divisible by all of
# the numbers from 1 to 20?
#
# 232792560

print = console.log

gcd = (a, b) ->
  while b > 0
    tmp = b
    b = a % b
    a = tmp
  a

lcm = (a, b) ->
  (a / gcd(a, b)) * b

euler005 = ->
  total = 1
  for i in [2 .. 20]
    total = lcm(total, i)
  total

print euler005()
