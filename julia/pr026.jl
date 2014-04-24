# Problem 26
#
# 13 September 2002
#
#
# A unit fraction contains 1 in the numerator. The decimal representation of
# the unit fractions with denominators 2 to 10 are given:
#
#     ^1/[2]  =  0.5
#     ^1/[3]  =  0.(3)
#     ^1/[4]  =  0.25
#     ^1/[5]  =  0.2
#     ^1/[6]  =  0.1(6)
#     ^1/[7]  =  0.(142857)
#     ^1/[8]  =  0.125
#     ^1/[9]  =  0.(1)
#     ^1/[10] =  0.1
#
# Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can
# be seen that ^1/[7] has a 6-digit recurring cycle.
#
# Find the value of d < 1000 for which ^1/[d] contains the longest recurring
# cycle in its decimal fraction part.
#
# 983

# Solve the discrete log problem.
# k for 10^k = 1 (mod n)
# For a composite number, the length will merely be the longest length
# of any of its factors, so no reason to call with composites.
# This will fail to terminate if the value has 2 or 5 has factors.
function dlog(n)
   result = 1
   temp = 10 % n
   while temp != 1
      result += 1
      temp = (temp * 10) % n
   end
   result
end

function solve()
   longest = 0
   longest_value = 0

   for p in primes(1000)
      if p < 7
         continue
      end

      size = dlog(p)
      if size > longest
         longest = size
         longest_value = p
      end
   end

   longest_value
end

println(solve())
