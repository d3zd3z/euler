----------------------------------------------------------------------
-- A perfect number is a number for which the sum of its proper
-- divisors is exactly equal to the number. For example, the sum of
-- the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which
-- means that 28 is a perfect number.
--
-- A number n is called deficient if the sum of its proper divisors is
-- less than n and it is called abundant if this sum exceeds n.
--
-- As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the
-- smallest number that can be written as the sum of two abundant
-- numbers is 24. By mathematical analysis, it can be shown that all
-- integers greater than 28123 can be written as the sum of two
-- abundant numbers. However, this upper limit cannot be reduced any
-- further by analysis even though it is known that the greatest
-- number that cannot be expressed as the sum of two abundant numbers
-- is less than this limit.
--
-- Find the sum of all the positive integers which cannot be written
-- as the sum of two abundant numbers.
----------------------------------------------------------------------

module Main where

import qualified Data.IntSet as S
import Primes

main :: IO ()
main = print $ sum $ filter (not . asSum) [1..28123]

abundants :: [Int]
abundants = [ x | x <- [1..28123], isAbundant x]

abundantSet :: S.IntSet
abundantSet = S.fromList abundants

asSum :: Int -> Bool
asSum num = any (\x -> S.member (num - x) abundantSet) abundants

isAbundant :: Int -> Bool
isAbundant x = sum (divisors x) > 2 * x

{-
-- Compute all of the divisors up numbers up to n, returning the
-- result starting with 1.
-- Basically as a sieve.
divisorSums :: [Int]
divisorSums = divs [(i, 1) | i <- [1..]]
   where
      divs ((n, sum):xs) = sum : divs [ ... | (x, xsum) <- xs ]
      next n (x, xsum) =
         if n `mod`
-}
