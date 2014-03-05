# Problem 14
#
# 05 April 2002
#
#
# The following iterative sequence is defined for the set of positive
# integers:
#
# n → n/2 (n is even)
# n → 3n + 1 (n is odd)
#
# Using the rule above and starting with 13, we generate the following
# sequence:
#
# 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
#
# It can be seen that this sequence (starting at 13 and finishing at 1)
# contains 10 terms. Although it has not been proved yet (Collatz Problem),
# it is thought that all starting numbers finish at 1.
#
# Which starting number, under one million, produces the longest chain?
#
# NOTE: Once the chain starts the terms are allowed to go above one million.
#
# 837799

proc simple(n: int): int =
  # Compute the chain length, starting from 'n', with simple recursion
  # and no caching.
  if n == 1:
    1
  elif n mod 2 == 0:
    1 + simple(n div 2)
  else:
    1 + simple(n * 3 + 1)

type
  TLengther = object of TObject
  TSimple = object of TLengther

method length(t: ref TLengther, n: int): int =
  quit "Abstract"

method length(t: ref TSimple, n: int): int = simple(n)

proc newSimple(): ref TSimple = new(result)

type
  TCached = object of TLengther
    cache: seq[int]

proc newCached(limit: int): ref TCached =
  new(result)
  result.cache = newSeq[int](limit)

proc getLen2(t: ref TCached, n: int): int

proc getLen(t: ref TCached, n: int): int =
  if n < t.cache.len:
    if t.cache[n] == 0:
      let tmp = getLen2(t, n)
      t.cache[n] = tmp
      result = tmp
    else:
      result = t.cache[n]
  else:
    result = getLen2(t, n)

proc getLen2(t: ref TCached, n: int): int =
  if n == 1:
    1
  elif n mod 2 == 0:
    1 + getLen(t, n div 2)
  else:
    1 + getLen(t, n * 3 + 1)

method length(t: ref TCached, n: int): int =
  getLen(t, n)

# This causes a compilation failure.
when false:
  proc cached(limit: int): (proc (n: int): int) =
    var cache = newSeq[int](limit)
    proc getLen2(n: int): int
    proc getLen(n: int): int =
      if n < limit:
        if cache[n] == 0:
          let tmp = getLen2(n)
          cache[n] = tmp
          result = tmp
        else:
          result = cache[n]
      else:
        result = getLen2(n)
    proc getLen2(n: int): int =
      if n == 1:
        1
      elif n mod 2 == 0:
        1 + getLen(n div 2)
      else:
        1 + getLen(n * 3 + 1)
    getLen

proc longest(lengther: ref TLengther): int =
  # Compute the longest chain, using the given lengther function.
  var largest = 0
  var largestInd = 0
  for i in 1..999_999:
    let tmp = lengther.length(i)
    if tmp > largest:
      largest = tmp
      largestInd = i
  return largestInd

# echo(longest(simple))
#echo(longest(cached(1000)))
proc solve() =
  # var ll = newSimple()
  var ll = newCached(100000)
  echo(longest(ll))
solve()
