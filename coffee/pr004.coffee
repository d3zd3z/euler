#! /usr/bin/env coffee
#
# Problem 4
#
# 16 November 2001
#
# A palindromic number reads the same both ways. The largest palindrome made
# from the product of two 2-digit numbers is 9009 = 91 x 99.
#
# Find the largest palindrome made from the product of two 3-digit numbers.
#
# 906609

print = console.log

# Note that JS doesn't require TCO.

reverse_digits = (n) ->
  result = 0
  while n > 0
    result = result * 10 + (n % 10)
    n = ~~(n / 10)
  result

is_palindrome = (n) ->
  n == reverse_digits(n)

euler004 = ->
  largest = 0
  for a in [100 .. 999]
    for b in [a .. 999]
      c = a * b
      if c > largest and is_palindrome(c)
        largest = c
  largest

print euler004()
