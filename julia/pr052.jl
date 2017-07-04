# Problem 52
#
# 12 September 2003
#
#
# It can be seen that the number, 125874, and its double, 251748, contain
# exactly the same digits, but in a different order.
#
# Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x,
# contain the same digits.
#
# 142857

# This is actually a bit of a well known property of the expansion of
# 1/7.  But, it is interesting to solve by searching, anyway.

using Primes

# We'll use the same trick as problem 49 to compute a 'number' value
# describing the bag of digits present.
early_primes = primes(29)

function number_value(num)
   result = Int64(1)
   while num > 0
      result *= early_primes[1 + mod(num, 10)]
      num = div(num, 10)
   end
   result
end

function solve()
   for base = 100000:199999
      bval = number_value(base)
      for mult = 2:6
         if number_value(base * mult) != bval
            break
         end
         if mult ==6
            return base
         end
      end
   end
end

println(solve())
