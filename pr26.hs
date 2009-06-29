----------------------------------------------------------------------
-- A unit fraction contains 1 in the numerator. The decimal
-- representation of the unit fractions with denominators 2 to 10 are
-- given:
--
-- A unit fraction contains 1 in the numerator. The decimal
-- representation of the unit fractions with denominators 2 to 10 are
-- given:
--
--     ^(1)/_(2)   =       0.5
--     ^(1)/_(3)   =       0.(3)
--     ^(1)/_(4)   =       0.25
--     ^(1)/_(5)   =       0.2
--     ^(1)/_(6)   =       0.1(6)
--     ^(1)/_(7)   =       0.(142857)
--     ^(1)/_(8)   =       0.125
--     ^(1)/_(9)   =       0.(1)
--     ^(1)/_(10)  =       0.1
--
-- Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle.
-- It can be seen that ^(1)/_(7) has a 6-digit recurring cycle.
--
-- Find the value of d < 1000 for which ^(1)/_(d) contains the longest
-- recurring cycle in its decimal fraction part.
----------------------------------------------------------------------

module Main where

import Primes

main :: IO ()
main = print $ snd $ maximum $ map (\x -> (digits x, x)) tries

-- A bit of number theory helped here.  First of all, we only need to
-- look at the prime numbers, since multiplying by other factors won't
-- change the length of the cycle.

tries :: [Int]
tries = dropWhile (<= 5) $ takeWhile (< 1000) primes

-- Then, to find the cycle length, solve the discrete logarithm
-- problem:  10^k = 1 (mod n)   which has to be done by brute force.
-- It's important to only call this with primes other than 2 and 5,
-- since there is no solution.
digits :: Int -> Int
digits n = dig 1
   where
      ni = toInteger n
      dig k = case (10^k `mod` ni) of
         1 -> k
         _ -> dig (k+1)

-- Return the remainder for each digit of the fraction, the first
-- repeat of the remainder is where we have a cycle.  This is not used
-- in the solution, but was helpful when examining what the remainders
-- were doing.

remainders :: Int -> [(Int,Int)]
remainders n = rm 10
   where
      rm d = (d `div` n, r) : rm (r * 10)
         where r = d `mod` n
