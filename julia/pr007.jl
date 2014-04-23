# Problem 7
#
# 28 December 2001
#
#
# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
# that the 6th prime is 13.
#
# What is the 10 001st prime number?
#
# 104743

function solve()
   size = 1000
   p = []
   while true
      p = primes(size)
      if length(p) > 10001
         break
      end
      size *= 8
   end
   p[10001]
end

println(solve())
