# Problem 57
#
# 21 November 2003
#
#
# It is possible to show that the square root of two can be expressed as an
# infinite continued fraction.
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
# The next three expansions are 99/70, 239/169, and 577/408, but the eighth
# expansion, 1393/985, is the first example where the number of digits in
# the numerator exceeds the number of digits in the denominator.
#
# In the first one-thousand expansions, how many fractions contain a
# numerator with more digits than denominator?
#
# 153

function digit_count(n)
   result = 0
   while n > 0
      result += 1
      n = div(n, 10)
   end
   result
end

function solve()
   count = 0
   s = bigint"1" + 1//2
   for i = 1:999
      s = 1//(s+1) + 1
      if digit_count(num(s)) > digit_count(den(s))
         count += 1
      end
   end
   count
end

println(solve())
