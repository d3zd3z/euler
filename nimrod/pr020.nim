# Problem 20
#
# 21 June 2002
#
#
# n! means n × (n − 1) × ... × 3 × 2 × 1
#
# For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
# and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 =
# 27.
#
# Find the sum of the digits in the number 100!
#
# 648

# Represent our number in base 10_000.

const base = 10_000

proc multiply(acc: var openarray[int], by: int) =
  var carry = 0
  for i in 0 .. acc.high:
    let temp = acc[i] * by + carry
    acc[i] = temp mod base
    carry = temp div base
  doAssert carry == 0

proc sumDigits(acc: int): int =
  var tmp = acc
  while tmp > 0:
    result += tmp mod 10
    tmp = tmp div 10

proc sumDigits(acc: openarray[int]): int =
  for value in acc:
    result += sumDigits(value)

proc solve =
  var acc = newSeq[int](40)
  acc[0] = 1

  for x in 2 .. 100:
    multiply(acc, x)

  echo sumDigits(acc)

when isMainModule:
  solve()
