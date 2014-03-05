# Problem 16
#
# 03 May 2002
#
#
# 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
#
# What is the sum of the digits of the number 2^1000?
#
# 1366

import sequtils

proc makeDigits: seq[int] =
  result = newSeq[int](302)
  result[0] = 1

proc double(digits: var seq[int]) =
  var carry = 0
  for i in 0 .. digits.len-1:
    let tmp = digits[i] * 2 + carry
    digits[i] = tmp mod 10
    carry = tmp div 10

  if carry != 0:
    quit "Numeric overflow"

proc solve =
  var digits = makeDigits()
  for i in 1..1000:
    double(digits)
  let answer = foldl(digits, a + b)
  echo(answer)

solve()
