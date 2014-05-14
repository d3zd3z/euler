# Problem 53
#
# 26 September 2003
#
#
# There are exactly ten ways of selecting three from five, 12345:
#
# 123, 124, 125, 134, 135, 145, 234, 235, 245, and 345
#
# In combinatorics, we use the notation, ^5C[3] = 10.
#
# In general,
#
# ^nC[r] = n!       ,where r ≤ n, n! = n×(n−1)×...×3×2×1, and 0! = 1.
#          r!(n−r)!
#
# It is not until n = 23, that a value exceeds one-million: ^23C[10] =
# 1144066.
#
# How many, not necessarily distinct, values of  ^nC[r], for 1 ≤ n ≤ 100,
# are greater than one-million?
#
# 4075

# To make this easier, we use "saturating" arithmetic that takes on a
# "saturation" value when the limit is exceeded.

import Base: zero, one, +

immutable SatNorm
   value :: Int
end
immutable Overflow
end
Saturated = Union(SatNorm, Overflow)

zero(::Type{Saturated}) = SatNorm(0)
one(::Type{Saturated}) = SatNorm(1)

+(::SatNorm, ::Overflow) = Overflow()
+(::Overflow, ::SatNorm) = Overflow()
+(::Overflow, ::Overflow) = Overflow()
function +(a::SatNorm, b::SatNorm)
   tmp = a.value + b.value
   if tmp > 1_000_000
      Overflow()
   else
      SatNorm(tmp)
   end
end

function solve()
   counter = 0

   buffer = zeros(Saturated, 101)
   buffer[1] = one(Saturated)
   for i in 2:101
      for j in i:-1:2
         buffer[j] += buffer[j-1]
      end
      counter += count(x -> isa(x, Overflow), buffer)
   end
   counter
end

println(solve())
