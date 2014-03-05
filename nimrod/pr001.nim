# Problem 1
#
# 05 October 2001
#
#
# If we list all the natural numbers below 10 that are multiples of 3 or 5,
# we get 3, 5, 6 and 9. The sum of these multiples is 23.
#
# Find the sum of all the multiples of 3 or 5 below 1000.
#
# 233168

proc solve* =
  var total = 0
  for i in 1 .. 999:
    if i mod 3 == 0 or i mod 5 == 0:
      total += i
  echo(total)

when isMainModule:
  solve()
