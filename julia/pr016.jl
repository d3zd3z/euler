# Problem 16
#
# 03 May 2002
#
#
# 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
#
# What is the sum of the digits of the number 2^1000?

function digitsum(n)
   res = 0
   while n > 0
      res += n % 10
      n = div(n, 10)
   end
   res
end

function solve()
    digitsum(BigInt(2)^1000)
end

println(solve())
