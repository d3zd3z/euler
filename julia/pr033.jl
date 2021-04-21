# Problem 33
#
# 20 December 2002
#
#
# The fraction ^49/[98] is a curious fraction, as an inexperienced
# mathematician in attempting to simplify it may incorrectly believe that ^
# 49/[98] = ^4/[8], which is correct, is obtained by cancelling the 9s.
#
# We shall consider fractions like, ^30/[50] = ^3/[5], to be trivial
# examples.
#
# There are exactly four non-trivial examples of this type of fraction, less
# than one in value, and containing two digits in the numerator and
# denominator.
#
# If the product of these four fractions is given in its lowest common
# terms, find the value of the denominator.
#
# 100

function isfrac(a, b)
   an = div(a, 10)
   am = a % 10
   bn = div(b, 10)
   bm = b % 10
   (an == bm && bn > 0 && am*b == bn * a) ||
      (am == bn && bm > 0 && an*b == bm*a)
end

function solve()
   total = 1 // 1
   for a = 10:99
      for b = a+1:99
         if isfrac(a, b)
            total *= a // b
         end
      end
   end
   denominator(total)
end

println(solve())
