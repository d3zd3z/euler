# Problem 35
#
# 17 January 2003
#
#
# The number, 197, is called a circular prime because all rotations of the
# digits: 197, 971, and 719, are themselves prime.
#
# There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37,
# 71, 73, 79, and 97.
#
# How many circular primes are there below one million?
#
# 55

# ndigits from Julia's lib is much more efficient than mine.

# To find a circular prime, we need to be able to go through all
# rotations of a number.

using Primes
import Base: iterate

struct Rotator{T}
   num :: T
   pow :: T
end

rotations(n) = Rotator(n, oftype(n, 10^(ndigits(n)-1)))

rotateit(r::Rotator{T}, i::T) where T = div(i, r.pow) + 10(mod(i, r.pow))

iterate(r::Rotator{T}) where T = (r.num, rotateit(r, r.num))
function iterate(r::Rotator{T}, i::T) where T
    if i == r.num
        nothing
    else
        (i, rotateit(r, i))
    end
end

function solve()
   count = 0
   for p in primes(1_000_000)
      if all(isprime, rotations(p))
         count += 1
      end
   end
   count
end

println(solve())
