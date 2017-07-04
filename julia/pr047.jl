# Problem 47
#
# 04 July 2003
#
#
# The first two consecutive numbers to have two distinct prime factors are:
#
# 14 = 2 × 7
# 15 = 3 × 5
#
# The first three consecutive numbers to have three distinct prime factors
# are:
#
# 644 = 2² × 7 × 23
# 645 = 3 × 5 × 43
# 646 = 2 × 17 × 19.
#
# Find the first four consecutive integers to have four distinct primes
# factors. What is the first of these numbers?
#
# 134043

using Primes

const expect = 4
function solve()
   count = 0
   i = 2
   while true
      if length(factor(i)) == expect
         count += 1
         if count == expect
            return i-expect+1
         end
      else
         count = 0
      end
      i += 1
   end
end

println(solve())
