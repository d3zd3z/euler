----------------------------------------------------------------------
-- The following iterative sequence is defined for the set of positive
-- integers:
--
-- n → n/2 (n is even)
-- n → 3n + 1 (n is odd)
--
-- Using the rule above and starting with 13, we generate the
-- following sequence:
-- 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
--
-- It can be seen that this sequence (starting at 13 and finishing at
-- 1) contains 10 terms. Although it has not been proved yet (Collatz
-- Problem), it is thought that all starting numbers finish at 1.
--
-- Which starting number, under one million, produces the longest
-- chain?
--
-- NOTE: Once the chain starts the terms are allowed to go above one
-- million.
----------------------------------------------------------------------

module Main where

import Data.Array.IArray
import Data.List (maximumBy)
import Data.Function (on)
import Data.Int (Int64)

-- Since we have to compare all of the values, we keep track of the
-- counts we've seen before.

main :: IO ()
--  main = print $ maximumBy (compare `on` snd) $ assocs counts
main = print $ maximumBy (compare `on` snd) $ counts3

counts :: Array Int64 Int64
counts = array (1,999999) [(i, count i i) | i <- [1..999999] ]
   where
      count _ 1 = 1
      count n i
         | i < n           = counts ! i
         | i `mod` 2 == 0  = 1 + (count n (i `div` 2))
         | otherwise       = 1 + (count n (i * 3 + 1))

-- Slight improvement, memoize all of the values in the desired range,
-- instead of just those strictly less than the current.
-- Realistically, it's not all that much faster.
counts2 :: Array Int64 Int64
counts2 = array (1,999999) [(i, count i) | i <- [1..999999] ]
   where
      count 1 = 1
      count i
         | i `mod` 2 == 0 = 1 + next (i `div` 2)
         | otherwise      = 1 + next (i * 3 + 1)
      next i
         | i <= 999999 = counts2 ! i
         | otherwise   = count i

-- Naive solution, for performance comparison with other languages.
counts3 :: [(Int64, Int64)]
counts3 = [(i, count i) | i <- [1..999999] ]
  where
    count 1 = 1
    count i
      | i `mod` 2 == 0 = 1 + count (i `div` 2)
      | otherwise      = 1 + count (i * 3 + 1)
