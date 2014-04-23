# Problem 4
#
# 16 November 2001
#
#
# A palindromic number reads the same both ways. The largest palindrome made
# from the product of two 2-digit numbers is 9009 = 91 × 99.
#
# Find the largest palindrome made from the product of two 3-digit numbers.
#
# 906609

function reverse(n)
   result = 0
   while n > 0
      result = result * 10 + n % 10
      n = div(n, 10)
   end
   result
end

ispalindrome(n) = n == reverse(n)

function solve()
   largest = 0
   for a = 100:999
      for b = a:999
         c = a * b
         if c > largest && ispalindrome(c)
            largest = c
         end
      end
   end
   largest
end

println(solve())
