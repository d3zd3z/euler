# Problem 3
#
# 02 November 2001
#
# The prime factors of 13195 are 5, 7, 13 and 29.
#
# What is the largest prime factor of the number 600851475143 ?
#
# 6857

var base = 600851475143'i64
var p = 3
while base > 1:
  if base mod p == 0:
    base = base div p
  else:
    p = p + 2
echo(p)
