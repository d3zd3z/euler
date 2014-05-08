# Problem 49
#
# 01 August 2003
#
#
# The arithmetic sequence, 1487, 4817, 8147, in which each of the terms
# increases by 3330, is unusual in two ways: (i) each of the three terms are
# prime, and, (ii) each of the 4-digit numbers are permutations of one
# another.
#
# There are no arithmetic sequences made up of three 1-, 2-, or 3-digit
# primes, exhibiting this property, but there is one other 4-digit
# increasing sequence.
#
# What 12-digit number do you form by concatenating the three terms in this
# sequence?
#
# 296962999629

# The first 10 primes are used to track the non-permutatable value of
# a number.
early_primes = primes(29)

# This is a unique identifier for a number, that doesn't account for
# the position of the digits, just which digits, and how many of each.
# It does this by multiplying in primes for each digit, using the
# first 10 primes for the digits 0-9.
function number_value(num)
   result = int64(1)
   while num > 0
      result *= early_primes[1 + mod(num, 10)]
      num = div(num, 10)
   end
   result
end

function solve()
   # These are all of the 4-digit primes.
   ps = primes(9999)
   filter!(x -> x >= 1000, ps)

   # Group them together in the groups that use the same 4 digits.
   groups = Dict{Int64, Vector{Int}}()
   for p in ps
      val = number_value(p)
      ary = get!(() -> Int[], groups, val)
      push!(ary, p)
   end

   # Walk through all combinations, determining which ones meet the
   # constraits of the problem description.
   solutions = Vector{Int}[]
   for ary in values(groups)
      # Sort, so the combinations will always be ordered.
      sort!(ary)
      for elts in combinations(ary, 3)
         if elts[2] - elts[1] == elts[3] - elts[2]
            push!(solutions, elts)
         end
      end
   end

   # The desired solution is the one that isn't the 1487 one given in
   # the problem description.
   filter!(solutions) do elts
      elts != [1487, 4817, 8147]
   end

   @assert length(solutions) == 1

   result = solutions[1]
   int64(result[1]) * 10^8 + result[2] * 10^4 + result[3]
end

println(solve())
