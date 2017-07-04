# Problem 46
#
# 20 June 2003
#
#
# It was proposed by Christian Goldbach that every odd composite number can
# be written as the sum of a prime and twice a square.
#
# 9 = 7 + 2×1^2
# 15 = 7 + 2×2^2
# 21 = 3 + 2×3^2
# 25 = 7 + 2×3^2
# 27 = 19 + 2×2^2
# 33 = 31 + 2×1^2
#
# It turns out that the conjecture was false.
#
# What is the smallest odd composite that cannot be written as the sum of a
# prime and twice a square?
#
# 5777

using Primes

pcache = primes(1024)
function cachedprimes(n)
   global pcache
   while n > last(pcache)
      pcache = primes(last(pcache) * 8)
   end
   pcache
end

function goldbach(n)
   for p in cachedprimes(n)
      if p == 2
         continue
      end
      if p > n
         break
      end
      b = div(n-p, 2)
      bsub = isqrt(b)
      if bsub*bsub == b
         return p
      end
   end
   return nothing
end

function solve()
   n = 9
   while true
      if isprime(n)
         n += 2
         continue
      end
      if goldbach(n) == nothing
         break
      end
      n += 2
   end
   n
end

println(solve())
