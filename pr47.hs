----------------------------------------------------------------------
-- The first two consecutive numbers to have two distinct prime
-- factors are:
--
-- 14 = 2 × 7
-- 15 = 3 × 5
--
-- The first three consecutive numbers to have three distinct prime
-- factors are:
--
-- 644 = 2² × 7 × 23
-- 645 = 3 × 5 × 43
-- 646 = 2 × 17 × 19.
--
-- Find the first four consecutive integers to have four distinct
-- primes factors. What is the first of these numbers?
----------------------------------------------------------------------

module Main where

import Primes
import Data.List

main :: IO ()
main = print $ general 4 [1..]

----------------------------------------------------------------------
-- Write up the two and three case as a sanity check, and to verify
-- that I've done the right thing for the general case.
two (a:b:bs)
   | null (af `intersect` bf) && length af == 2 && length bf == 2  = (a, af, bf)
   | otherwise  = two (b:bs)
      where
         af = primeFactors a
         bf = primeFactors b

three (a:b:c:cs)
   | null (af `intersect` bf) &&
     null (bf `intersect` cf) &&
     null (af `intersect` cf) &&
      length af == 3 &&
      length bf == 3 &&
      length cf == 3
         = (a, af, bf, cf)
   | otherwise  = three (b:c:cs)
      where
         af = primeFactors a
         bf = primeFactors b
         cf = primeFactors c

general :: Int -> [Int] -> ([Int], [[(Int, Int)]])
general count nums
   | and (map (\x -> count == length x) factors)  && unique factors
      = (items, factors)
   | otherwise = general count (tail nums)
   where
      items = take count nums
      factors = map primeFactors items

-- Ensure that every list in the given lists contains no entries in
-- common with each other.
unique :: Eq a => [[a]] -> Bool
unique lst = full == nub full
   where full = concat lst
