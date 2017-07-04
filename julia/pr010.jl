# Problem 10
#
# 08 February 2002
#
#
# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
#
# Find the sum of all the primes below two million.
#
# 142913828922

using Primes

function solve()
   p = primes(2_000_000)
   sum(p)
end

println(solve())
