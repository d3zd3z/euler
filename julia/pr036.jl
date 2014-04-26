# Problem 36
#
# 31 January 2003
#
#
# The decimal number, 585 = 1001001001[2] (binary), is palindromic in both
# bases.
#
# Find the sum of all numbers, less than one million, which are palindromic
# in base 10 and base 2.
#
# (Please note that the palindromic number, in either base, may not include
# leading zeros.)
#
# 872187

function revdigits(n, base)
   result = 0
   while n > 0
      result = result * base + mod(n, base)
      n = div(n, base)
   end
   result
end

ispalindrome(n, base) = n == revdigits(n, base)

function solve()
   total = 0
   for i = 1:999_999
      if ispalindrome(i, 10) && ispalindrome(i, 2)
         total += i
      end
   end
   total
end

println(solve())
