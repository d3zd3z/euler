# Problem 27
#
# 27 September 2002
#
#
# Euler published the remarkable quadratic formula:
#
# n² + n + 41
#
# It turns out that the formula will produce 40 primes for the consecutive
# values n = 0 to 39. However, when n = 40, 40^2 + 40 + 41 = 40(40 + 1) + 41
# is divisible by 41, and certainly when n = 41, 41² + 41 + 41 is clearly
# divisible by 41.
#
# Using computers, the incredible formula  n² − 79n + 1601 was discovered,
# which produces 80 primes for the consecutive values n = 0 to 79. The
# product of the coefficients, −79 and 1601, is −126479.
#
# Considering quadratics of the form:
#
#     n² + an + b, where |a| < 1000 and |b| < 1000
#
#     where |n| is the modulus/absolute value of n
#     e.g. |11| = 11 and |−4| = 4
#
# Find the product of the coefficients, a and b, for the quadratic
# expression that produces the maximum number of primes for consecutive
# values of n, starting with n = 0.
#
# -59231

function prime_count(a, b)
   n = 0
   while true
      p = n*n + a*n + b
      if p < 2 || !isprime(p)
         break
      end
      n += 1
   end
   n
end

function solve()
   big = 0
   big_prod = 0

   for a = -999:999
      for b = -999:999
         count = prime_count(a, b)
         if count > big
            big = count
            big_prod = a * b
         end
      end
   end

   big_prod
end

println(solve())
