# Problem 12
#
# 08 March 2002
#
#
# The sequence of triangle numbers is generated by adding the natural
# numbers. So the 7^th triangle number would be 1 + 2 + 3 + 4 + 5 + 6 + 7 =
# 28. The first ten terms would be:
#
# 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
#
# Let us list the factors of the first seven triangle numbers:
#
#      1: 1
#      3: 1,3
#      6: 1,2,3,6
#     10: 1,2,5,10
#     15: 1,3,5,15
#     21: 1,3,7,21
#     28: 1,2,4,7,14,28
#
# We can see that 28 is the first triangle number to have over five
# divisors.
#
# What is the value of the first triangle number to have over five hundred
# divisors?
#
# 76576500

using Primes

function divisorcount(n)
   result = 1
   for (b, power) in factor(n)
      result *= (power + 1)
   end
   result
end

function solve()
   n = 1
   tri = 1
   while true
      if divisorcount(tri) > 500
         break
      end
      n += 1
      tri += n
   end
   tri
end

println(solve())
