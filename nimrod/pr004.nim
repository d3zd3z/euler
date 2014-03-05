# Problem 4
#
# 16 November 2001
#
# A palindromic number reads the same both ways. The largest palindrome made
# from the product of two 2-digit numbers is 9009 = 91 × 99.
#
# Find the largest palindrome made from the product of two 3-digit numbers.
#
# 906609

proc revDigits(num: int64, base: int = 10): int64 =
  var tmp = num
  while tmp > 0:
    result = result * base + tmp mod base
    tmp = tmp div base

proc isPalindrome(num: int64, base: int = 10): bool =
  num == revDigits(num, base)

var biggest = 0
for a in countup(100, 999):
  for b in countup(a, 999):
    let ab = a * b
    if ab > biggest and isPalindrome(ab):
      biggest = ab
echo(biggest)
