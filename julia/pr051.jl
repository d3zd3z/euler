# Problem 51
#
# 29 August 2003
#
#
# By replacing the 1^st digit of *3, it turns out that six of the nine
# possible values: 13, 23, 43, 53, 73, and 83, are all prime.
#
# By replacing the 3^rd and 4^th digits of 56**3 with the same digit, this
# 5-digit number is the first example having seven primes among the ten
# generated numbers, yielding the family: 56003, 56113, 56333, 56443, 56663,
# 56773, and 56993. Consequently 56003, being the first member of this
# family, is the smallest prime with this property.
#
# Find the smallest prime which, by replacing part of the number (not
# necessarily adjacent digits) with the same digit, is part of an eight
# prime value family.
#
# 121313

# First thing to reason is that the substitute digit must be initially
# either 0, 1, or 2, otherwise there aren't enough digits to choose
# from.
#
# Second, it won't help to have 2 or 4 digits replaced, since by
# choosing 8, one of the results will always be divisible by 3 (in
# [0:9] .* 2 .% 3, one can choose at most 7 of the numbers without
# hitting all of the moduli).  The only one that gives us a
# possibility of not hitting a multiple of 3 is is a multiple of 3
# digits.  We'll start by just doing groups of 3.

using Primes
using Combinatorics

# Build a number out of the given string, substituting all of the
# digits in 'places' with 'replacement'.
function build(text, places, replacement)
   ary = [c-'0' for c in text]
   for p in places
      ary[p] = replacement
   end
   result = 0
   for v in ary
      result = result * 10 + v
   end
   result
end

function check(number)
   text = string(number)
   for early in "012"
      for places in combinations(findall(x -> x == early, text), 3)
         count = 0
         for i in early-'0':9
            if isprime(build(text, places, i))
               count += 1
            end
         end
         if count >= 8
            return number
         end
      end
   end
end

function solve()
   for p in primes(1_000_000)
      n = check(p)
      if n != nothing
         return n
      end
   end
end

println(solve())
