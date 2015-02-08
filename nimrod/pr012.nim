# Problem 12
#
# 08 March 2002
#
#
# The sequence of triangle numbers is generated by adding the natural
# numbers. So the 7^th triangle number would be 1 + 2 + 3 + 4 + 5 + 6 + 7 =
# 28. The first ten terms would be:
#
# 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
#
# Let us list the factors of the first seven triangle numbers:
#
#      1: 1
#      3: 1,3
#      6: 1,2,3,6
#     10: 1,2,5,10
#     15: 1,3,5,15
#     21: 1,3,7,21
#     28: 1,2,4,7,14,28
#
# We can see that 28 is the first triangle number to have over five
# divisors.
#
# What is the value of the first triangle number to have over five hundred
# divisors?
#
# 7657600

import sieve

proc divisorCount(sv: var Sieve, n: int): int =
  result = 1
  var tmp = n
  var prime = 2

  while tmp > 1:
    var divideCount = 0
    while tmp mod prime == 0:
      tmp = tmp div prime
      divideCount += 1

    result *= divideCount + 1

    if tmp > 1:
      prime = sv.nextPrime(prime)

proc solve() =
  var sv = InitSieve()
  var n = 1
  var tri = 1
  while true:
    if divisorCount(sv, tri) > 500:
      break
    n += 1
    tri += n
  echo(tri)
solve()
