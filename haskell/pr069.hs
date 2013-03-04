----------------------------------------------------------------------
-- Problem 69
--
-- 07 May 2004
--
--
-- Euler's Totient function, φ(n) [sometimes called the phi function], is used to
-- determine the number of numbers less than n which are relatively prime to n.
-- For example, as 1, 2, 4, 5, 7, and 8, are all less than nine and relatively
-- prime to nine, φ(9)=6.
--
-- ┌──┬────────────────┬────┬─────────┐
-- │n │Relatively Prime│φ(n)│n/φ(n)   │
-- ├──┼────────────────┼────┼─────────┤
-- │2 │1               │1   │2        │
-- ├──┼────────────────┼────┼─────────┤
-- │3 │1,2             │2   │1.5      │
-- ├──┼────────────────┼────┼─────────┤
-- │4 │1,3             │2   │2        │
-- ├──┼────────────────┼────┼─────────┤
-- │5 │1,2,3,4         │4   │1.25     │
-- ├──┼────────────────┼────┼─────────┤
-- │6 │1,5             │2   │3        │
-- ├──┼────────────────┼────┼─────────┤
-- │7 │1,2,3,4,5,6     │6   │1.1666...│
-- ├──┼────────────────┼────┼─────────┤
-- │8 │1,3,5,7         │4   │2        │
-- ├──┼────────────────┼────┼─────────┤
-- │9 │1,2,4,5,7,8     │6   │1.5      │
-- ├──┼────────────────┼────┼─────────┤
-- │10│1,3,7,9         │4   │2.5      │
-- └──┴────────────────┴────┴─────────┘
--
-- It can be seen that n=6 produces a maximum n/φ(n) for n ≤ 10.
--
-- Find the value of n ≤ 1,000,000 for which n/φ(n) is a maximum.
----------------------------------------------------------------------

module Main where

import Data.List
import Nums

{-
-- This is a bit easier to do with ratios.
totient :: Int -> Int
totient n =
   let factors = map fst $ primeFactors n in
   let answer = product $ n%1 : map (\x -> 1%1 - 1%x) factors in
   assert (denominator answer == 1) (numerator answer)

-- Ugh, misread the problem.
solve :: Int
solve =
   fst $ maximumBy (comparing snd) [ (x, totient x) | x <- [1..1000000]]
-}

-- The totient is related the the unique prime factors.  Multiples of
-- a prime will make the ratio smaller, so we only want each to occur
-- once.  The result will also be largest by maximizing the number of
-- prime factors.  So, the result is the largest number composed of
-- the initial primes.

solve :: Int
solve = last $ takeWhile (<= 1000000) $ map product $ inits primes

main :: IO ()
main = print solve
