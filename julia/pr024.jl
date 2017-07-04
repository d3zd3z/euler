# Problem 24
#
# 16 August 2002
#
#
# A permutation is an ordered arrangement of objects. For example, 3124 is
# one possible permutation of the digits 1, 2, 3 and 4. If all of the
# permutations are listed numerically or alphabetically, we call it
# lexicographic order. The lexicographic permutations of 0, 1 and 2 are:
#
# 012   021   102   120   201   210
#
# What is the millionth lexicographic permutation of the digits 0, 1, 2, 3,
# 4, 5, 6, 7, 8 and 9?
#
# 2783915460

using Combinatorics

function solve()
   count = 0
   for perm in permutations("0123456789")
      count += 1
      if count == 1_000_000
         return string(perm...)
      end
   end
end

println(solve())
