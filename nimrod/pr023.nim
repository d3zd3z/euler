# Problem 23
#
# 02 August 2002
#
#
# A perfect number is a number for which the sum of its proper divisors is
# exactly equal to the number. For example, the sum of the proper divisors
# of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect
# number.
#
# A number n is called deficient if the sum of its proper divisors is less
# than n and it is called abundant if this sum exceeds n.
#
# As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the
# smallest number that can be written as the sum of two abundant numbers is
# 24. By mathematical analysis, it can be shown that all integers greater
# than 28123 can be written as the sum of two abundant numbers. However,
# this upper limit cannot be reduced any further by analysis even though it
# is known that the greatest number that cannot be expressed as the sum of
# two abundant numbers is less than this limit.
#
# Find the sum of all the positive integers which cannot be written as the
# sum of two abundant numbers.
#
# 4179871

import sets

# We are computing all of the divisors, it is much faster to use a
# modified sieve and compute the divisors as we go.
proc makeDivisors(limit: int): seq[int] =
  result = newSeq[int](limit)
  for i in result.low .. result.high:
    result[i] = 1

  for i in 2 .. limit-1:
    var n = i + i
    while n < limit:
      result[n] += i
      n += i

proc makeAbundants(limit: int): seq[int] =
  let divisors = makeDivisors(limit)
  result = newSeq[int](0)
  for i in divisors.low+1 .. divisors.high:
    if i < divisors[i]:
      result.add(i)

proc solve =
  var notAdd = initSet[int]()
  let abundants = makeAbundants(28124)

  for ai in abundants.low .. abundants.high:
    let a = abundants[ai]
    for bi in ai .. abundants.high:
      let sum = a + abundants[bi]
      if sum > 28123: break
      notAdd.incl(sum)

  var total = 0
  for i in 1 .. 28123:
    if not notAdd.contains(i):
      total += i
  echo total

when isMainModule:
  solve()
