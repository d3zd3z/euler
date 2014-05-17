# Problem 56
#
# 07 November 2003
#
#
# A googol (10^100) is a massive number: one followed by one-hundred zeros;
# 100^100 is almost unimaginably large: one followed by two-hundred zeros.
# Despite their size, the sum of the digits in each number is only 1.
#
# Considering natural numbers of the form, a^b, where a, b < 100, what is
# the maximum digital sum?
#
# 972

function digit_sum(n)
   result = 0
   while n > 0
      result += int(mod(n, 10))
      n = div(n, 10)
   end
   result
end

function solve()
   maxs = 0
   for a in 1:99
      ba = BigInt(a)
      for b in 1:99
         tmp = ba ^ b
         s = digit_sum(tmp)
         if s > maxs
            maxs = s
         end
      end
   end
   maxs
end

println(solve())
