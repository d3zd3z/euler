----------------------------------------------------------------------
-- Problem 70
--
-- 21 May 2004
--
-- Euler's Totient function, φ(n) [sometimes called the phi function], is used to
-- determine the number of positive numbers less than or equal to n which are
-- relatively prime to n. For example, as 1, 2, 4, 5, 7, and 8, are all less than
-- nine and relatively prime to nine, φ(9)=6.
-- The number 1 is considered to be relatively prime to every positive number, so
-- φ(1)=1.
--
-- Interestingly, φ(87109)=79180, and it can be seen that 87109 is a permutation
-- of 79180.
--
-- Find the value of n, 1 < n < 10^7, for which φ(n) is a permutation of n and the
-- ratio n/φ(n) produces a minimum.
----------------------------------------------------------------------
-- 8319823

module Main where

import Data.List
import Data.Ord
import Data.Ratio
import Nums

-- Some analysis shows that the solution will be a number < 10e7
-- comprised of two primes (two that are close together as well, but
-- no need to restrict our search for that).

isPermutation :: Int -> Int -> Bool
isPermutation a b = sort (digits a) == sort (digits b)

-- For given primes, return their Just(n/φ(n)) is the totient is a
-- permutation of the number, or Nothing.
totValue :: Int -> Int -> Maybe (Ratio Int)
totValue a b =
   let tot = (a-1) * (b-1) in
   if isPermutation (a*b) tot
      then Just $ (a*b)%tot
      else Nothing

-- The cap is the sqrt of the limit.  The lower bound is just a guess.
-- The lower numbers have a larger search space.
values :: [(Int, Ratio Int)]
values =
   [ (a*b, tv) |
      a <- dropWhile (<1000) $ takeWhile (<3162) primes,
      b <- takeWhile (<(10000000 `div` a)) primes,
      let prod = a * b,
      prod < 10000000,
      Just tv <- [totValue a b] ]

solve :: Int
solve =
   fst $ minimumBy (comparing snd) values

main :: IO ()
main = print solve
