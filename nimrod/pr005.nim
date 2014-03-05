# Problem 5
#
# 30 November 2001
#
#
# 2520 is the smallest number that can be divided by each of the numbers
# from 1 to 10 without any remainder.
#
# What is the smallest positive number that is evenly divisible by all of
# the numbers from 1 to 20?
#
# 232792560

proc gcd(a, b: int): int =
  var a = a
  var b = b
  var r = a mod b
  while r > 0:
    a = b
    b = r
    r = a mod b
  result = b

proc lcm(a, b: int): int =
  (a div gcd(a, b)) * b

var reduct = 1
for i in 2..20:
  reduct = lcm(reduct, i)
echo(reduct)
