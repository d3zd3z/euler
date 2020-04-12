# Problem 23
#
# 02 August 2002
#
#
# A perfect number is a number for which the sum of its proper divisors is
# exactly equal to the number. For example, the sum of the proper divisors
# of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect
# number.
#
# A number n is called deficient if the sum of its proper divisors is less
# than n and it is called abundant if this sum exceeds n.
#
# As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the
# smallest number that can be written as the sum of two abundant numbers is
# 24. By mathematical analysis, it can be shown that all integers greater
# than 28123 can be written as the sum of two abundant numbers. However,
# this upper limit cannot be reduced any further by analysis even though it
# is known that the greatest number that cannot be expressed as the sum of
# two abundant numbers is less than this limit.
#
# Find the sum of all the positive integers which cannot be written as the
# sum of two abundant numbers.
#
# 4179871

function make_divisors(limit)
   result = ones(Int64, limit)
   for i = 2:limit
      for j = (i+i):i:limit
         result[j] += i
      end
   end
   result
end

function make_abundants(limit)
   divs = make_divisors(limit)
   result = Int64[]
   for i = 1:limit
      if i < divs[i]
         push!(result, i)
      end
   end
   result
end

function solve()
   notadd = BitSet()
   limit = 28124
   abundants = make_abundants(limit)

   for ai = 1:lastindex(abundants)
      a = abundants[ai]
      for bi = ai:lastindex(abundants)
         sum = a + abundants[bi]
         if sum > limit
            break
         end
         push!(notadd, sum)
      end
   end

   total = 0
   for i in 1:limit
      if !(i in notadd)
         total += i
      end
   end
   total
end

println(solve())
