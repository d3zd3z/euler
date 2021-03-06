# Problem 30
#
# 08 November 2002
#
#
# Surprisingly there are only three numbers that can be written as the sum
# of fourth powers of their digits:
#
#     1634 = 1^4 + 6^4 + 3^4 + 4^4
#     8208 = 8^4 + 2^4 + 0^4 + 8^4
#     9474 = 9^4 + 4^4 + 7^4 + 4^4
#
# As 1 = 1^4 is not a sum it is not included.
#
# The sum of these numbers is 1634 + 8208 + 9474 = 19316.
#
# Find the sum of all the numbers that can be written as the sum of fifth
# powers of their digits.
#
# 443839

# Looking at n*9^5, we can quickly determine that there cannot be a
# 7-digit number that works.  So, only need to compute up to n=6.

# Sum the digits of 'x' raised to the given power.
function sum_power(x, pow)
   result = 0
   while x > 0
      digit = x % 10
      x = div(x, 10)
      result += digit ^ pow
   end
   result
end

function solve()
   result = 0
   for x = 2:sum_power(999999, 5)
      if sum_power(x, 5) == x
         result += x
      end
   end
   result
end

println(solve())
