#! /usr/bin/env ruby19
$-w = true
######################################################################
# It is possible to show that the square root of two can be expressed
# as an infinite continued fraction.
#
# √ 2 = 1 + 1/(2 + 1/(2 + 1/(2 + ... ))) = 1.414213...
#
# By expanding this for the first four iterations, we get:
#
# 1 + 1/2 = 3/2 = 1.5
# 1 + 1/(2 + 1/2) = 7/5 = 1.4
# 1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 1.41666...
# 1 + 1/(2 + 1/(2 + 1/(2 + 1/2))) = 41/29 = 1.41379...
#
# The next three expansions are 99/70, 239/169, and 577/408, but the
# eighth expansion, 1393/985, is the first example where the number of
# digits in the numerator exceeds the number of digits in the
# denominator.
#
# In the first one-thousand expansions, how many fractions contain a
# numerator with more digits than denominator?
######################################################################

def expand(count)
  num = 1
  den = 2
  count.downto(1) do |n|
    sum = n == 1 ? 1 : 2
    num, den = den, sum*den + num
  end
  [den, num]
end

def log10(num)
  result = 0
  while num > 0 do
    result += 1
    num /= 10
  end
  result
end

count = 0
1.upto(1000) do |n|
  num, den = expand n
  count += 1 if log10(num) > log10(den)
end

puts count
