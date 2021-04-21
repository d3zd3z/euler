# Problem 32
#
# 06 December 2002
#
#
# We shall say that an n-digit number is pandigital if it makes use of all
# the digits 1 to n exactly once; for example, the 5-digit number, 15234, is
# 1 through 5 pandigital.
#
# The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing
# multiplicand, multiplier, and product is 1 through 9 pandigital.
#
# Find the sum of all products whose multiplicand/multiplier/product
# identity can be written as a 1 through 9 pandigital.
#
# HINT: Some products can be obtained in more than one way so be sure to
# only include it once in your sum.
#
# 45228

using Combinatorics

# Extract digits out of the number.
function ofdigits(digits)
   result = 0
   for dig in digits
      result = result * 10 + dig
   end
   result
end

function make_groupings!(rset, digits)
   for i = 2:lastindex(digits)-2
      for j = i+1:lastindex(digits)-1
         a = ofdigits(digits[1:i-1])
         b = ofdigits(digits[i:j-1])
         c = ofdigits(digits[j:end])
         if a*b == c
            push!(rset, c)
         end
      end
   end
end

function solve()
   rset = Set{Int64}()
   for perm in permutations([Int8(i) for i in 1:9])
      make_groupings!(rset, perm)
   end
   sum(rset)
end

println(solve())
