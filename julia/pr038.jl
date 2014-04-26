# Problem 38
#
# 28 February 2003
#
#
# Take the number 192 and multiply it by each of 1, 2, and 3:
#
#     192 × 1 = 192
#     192 × 2 = 384
#     192 × 3 = 576
#
# By concatenating each product we get the 1 to 9 pandigital, 192384576. We
# will call 192384576 the concatenated product of 192 and (1,2,3)
#
# The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4,
# and 5, giving the pandigital, 918273645, which is the concatenated product
# of 9 and (1,2,3,4,5).
#
# What is the largest 1 to 9 pandigital 9-digit number that can be formed as
# the concatenated product of an integer with (1,2, ... , n) where n > 1?
#
# 932718654

# Is this number a full 9-element pandigital number.
# Compute this by collecting each digit, and tracking them as bits in
# a value, making sure no bits are set twice, and at the end that all
# of the desired bits are set.
function is_pandigital(number)
   bits = 0
   while number > 0
      m = mod(number, 10)
      bit = 1 << m
      if (bits & bit) != 0
         return false
      end
      bits |= bit
      number = div(number, 10)
   end
   bits == 1022  # 1-9 without the zero.
end

# Concatenate the two numbers in decimal.
concatenate(a, b) = a * 10^ndigits(b) + b

# Given a 'base' according to the problem, multiply successively by
# the digits start with 1 until we reach >= 9 digits.
function large_sum(base)
   result = 0
   x = 1
   while result < 100_000_000
      result = concatenate(result, base * x)
      x += 1
   end
   result
end

function solve()
   largest = 0
   for i = 1:9999
      s = large_sum(i)
      if s > largest && is_pandigital(s)
         largest = s
      end
   end
   largest
end

println(solve())
