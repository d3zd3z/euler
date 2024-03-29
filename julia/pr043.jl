# Problem 43
#
# 09 May 2003
#
#
# The number, 1406357289, is a 0 to 9 pandigital number because it is made
# up of each of the digits 0 to 9 in some order, but it also has a rather
# interesting sub-string divisibility property.
#
# Let d[1] be the 1^st digit, d[2] be the 2^nd digit, and so on. In this
# way, we note the following:
#
#   • d[2]d[3]d[4]=406 is divisible by 2
#   • d[3]d[4]d[5]=063 is divisible by 3
#   • d[4]d[5]d[6]=635 is divisible by 5
#   • d[5]d[6]d[7]=357 is divisible by 7
#   • d[6]d[7]d[8]=572 is divisible by 11
#   • d[7]d[8]d[9]=728 is divisible by 13
#   • d[8]d[9]d[10]=289 is divisible by 17
#
# Find the sum of all 0 to 9 pandigital numbers with this property.
#
# 16695334890

using Primes
using Combinatorics

const divisors = primes(17)

function undigits(a::Vector{T}) where T<:Integer
   result = zero(T)
   for i in a
      result = result * 10 + i
   end
   result
end

function check(a::Vector{T}) where T<:Integer
   offset = 2
   for p in divisors
      if undigits(a[offset:offset+2]) % p != 0
         return false
      end
      offset += 1
   end
   true
end

function solve()
   total = 0
   for num = permutations(0:9)
      if check(num)
         total += undigits(num)
      end
   end
   total
end

println(solve())
