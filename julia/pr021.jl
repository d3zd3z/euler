# Problem 21
#
# 05 July 2002
#
#
# Let d(n) be defined as the sum of proper divisors of n (numbers less than
# n which divide evenly into n).
# If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair
# and each of a and b are called amicable numbers.
#
# For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22,
# 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1,
# 2, 4, 71 and 142; so d(284) = 220.
#
# Evaluate the sum of all the amicable numbers under 10000.
#
# 31626

# TODO: This can be done by building a sieve directly of the divisors.

using Primes

function spread(facts)
   len = length(facts)
   if len == 0
      [1]
   else
      prime, power = facts[1]
      rest = spread(facts[2:end])

      vec(rest * (prime .^ (0:power)'))
      #result = []
      #p = 1
      #for x = 0:power
      #   result = vcat(result, rest .* p)
      #   if x < power
      #      p *= prime
      #   end
      #end
      #result
   end
end

function divisors(n)
   facts = collect(factor(n))
   sort!(spread(facts))
end

proper_divisor_sum(n) = sum(divisors(n)) - n

function is_amicable(a)
   if a >= 10_000
      return false
   end
   b = proper_divisor_sum(a)
   if b >= 10_000 || a == b
      return false
   end
   c = proper_divisor_sum(b)
   a == c
end

function solve()
   total = 0
   for i = 2:9_999
      if is_amicable(i)
         total += i
      end
   end
   total
end

println(solve())
