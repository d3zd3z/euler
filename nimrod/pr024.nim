# Problem 24
#
# 16 August 2002
#
#
# A permutation is an ordered arrangement of objects. For example, 3124 is
# one possible permutation of the digits 1, 2, 3 and 4. If all of the
# permutations are listed numerically or alphabetically, we call it
# lexicographic order. The lexicographic permutations of 0, 1 and 2 are:
#
# 012   021   102   120   201   210
#
# What is the millionth lexicographic permutation of the digits 0, 1, 2, 3,
# 4, 5, 6, 7, 8 and 9?
#
# 2783915460

import algorithm

proc next_permutation[T](a: var seq[T]): bool {.discardable.} =
  var k = -1
  var ll = -1
  for x in 0 .. len(a)-2:
    if a[x] < a[x+1]:
      k = x
  if k < 0:
    return false

  for x in k+1 .. len(a)-1:
    if a[k] < a[x]:
      ll = x
  swap(a[k], a[ll])
  reverse(a, k + 1, len(a)-1)
  return true

proc to_number[T](a : seq[T]): T =
  var result: T = 0
  for digit in a:
    result = result * 10 + digit
  return result

proc solve =
  var a = @[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  for i in 2 .. 1000000:
    next_permutation(a)
  echo($to_number(a))

when isMainModule:
  solve()
