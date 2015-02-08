# Problem 21
#
# 05 July 2002
#
#
# Let d(n) be defined as the sum of proper divisors of n (numbers less than
# n which divide evenly into n).
# If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair
# and each of a and b are called amicable numbers.
#
# For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22,
# 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1,
# 2, 4, 71 and 142; so d(284) = 220.
#
# Evaluate the sum of all the amicable numbers under 10000.
# 31626

import sieve

# TODO: It would be better to just compute the divisors instead of the
# prime table, and then look things up from there.

proc properDivSum(t: var Sieve, n: int): int =
  for d in t.divisors(n):
    result += d
  result -= n

proc isAmicable(t: var Sieve, a: int): bool =
  let b = t.properDivSum(a)
  if a == b or b == 0:
    return false
  let c = t.properDivSum(b)
  return a == c

proc solve =
  var sv = InitSieve()
  var sum = 0
  for i in 1 .. 9_999:
    if sv.isAmicable(i):
      sum += i
  echo sum

when isMainModule:
  solve()
