# Prime sieve.

import algorithm
import intsets

const defaultSize = 8192

type
  Sieve* = object
    composites: IntSet
    limit: int

proc fill(t: var Sieve, size: int) =
  var v = initIntSet()
  v.incl(0)
  v.incl(1)

  var pos = 2
  while pos <= size:
    if v.contains(pos):
      pos += 2
    else:
      var n = pos + pos
      while n <= size:
        v.incl(n)
        n += pos
      if pos == 2:
        pos += 1
      else:
        pos += 2
  t.composites = v
  t.limit = size

proc IniTSieve*(): Sieve =
  result.fill(defaultSize)

proc isPrime*(t: var Sieve, n: int): bool =
  if n >= t.limit:
    var nlimit = t.limit
    while nlimit < n:
      nlimit *= 8
    t.fill(nlimit)

  not t.composites.contains(n)

proc nextPrime*(t: var Sieve, n: int): int =
  if n == 2:
    return 3

  result = n + 2
  while not t.isPrime(result):
    result += 2

type
  Factor* = object
    prime*: int
    power*: int

proc factorize*(t: var Sieve, n: int): seq[Factor] =
  result = newSeq[Factor](0)

  var tmp = n
  var prime = 2
  var count = 0

  while tmp > 1:
    if tmp mod prime == 0:
      tmp = tmp div prime
      count += 1
    else:
      if count > 0:
        result.add(Factor(prime: prime, power: count))
        count = 0

      if tmp > 1:
        prime = t.nextPrime(prime)

  if count > 0:
    result.add(Factor(prime: prime, power: count))

proc spread(factors: seq[Factor]): seq[int] =
  result = newSeq[int](0)
  let len = factors.len
  if len == 0:
    result.add(1)
  else:
    let x = factors[0]
    let rest = spread(factors[1..factors.high])

    var power = 1
    for i in 0 .. x.power:
      for elt in rest:
        result.add(elt * power)
      if i < power:
        power *= x.prime

proc divisors*(t: var Sieve, n: int): seq[int] =
  result = spread(t.factorize(n))
  sort(result, cmp[int])

when isMainModule:
  var sv = InitSieve()
  let facts = sv.divisors(120)
  echo repr(facts)
