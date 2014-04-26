# Problem 41
#
# 11 April 2003
#
#
# We shall say that an n-digit number is pandigital if it makes use of all
# the digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital
# and is also prime.
#
# What is the largest n-digit pandigital prime that exists?
#
# 7652413

function is_pandigital(num)
   digits = zeros(Int64, 10)
   count = 0
   while num > 0
      digits[num % 10 + 1] += 1
      count += 1
      num = div(num, 10)
   end

   if digits[1] > 0
      return false
   end

   for i in 2:count+1
      if digits[i] != 1
         return false
      end
   end
   true
end

function solve()
   for p in reverse!(primes(9_999_999))
      if is_pandigital(p)
         return p
      end
   end
end

println(solve())
