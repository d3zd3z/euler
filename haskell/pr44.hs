----------------------------------------------------------------------
-- Pentagonal numbers are generated by the formula, Pn=n(3n−1)/2. The
-- first ten pentagonal numbers are:
--
-- 1, 5, 12, 22, 35, 51, 70, 92, 117, 145, ...
--
-- It can be seen that P4 + P7 = 22 + 70 = 92 = P8. However, their
-- difference, 70 − 22 = 48, is not pentagonal.
--
-- Find the pair of pentagonal numbers, Pj and Pk, for which their sum
-- and difference is pentagonal and D = |Pk − Pj| is minimised; what
-- is the value of D?
----------------------------------------------------------------------

-- Let's assume

module Main where

import Nums
import Data.List
import qualified Data.IntSet as IntSet
import Data.IntSet (IntSet)

main :: IO ()
main = putStrLn $ show solve

-- Assume this fits in an Int, but make it easy to change if it
-- doesn't.
type PInt = Int

pentagonal :: PInt -> PInt
pentagonal n = n * (3 * n - 1) `div` 2

-- Solving the pentagonal forumla for 'n', using the quadratic gives
-- us [ n = (sqrt(24*x+1) + 1) / 6 ].

-- BTW, I don't think this is actually correct.  It scans by size of
-- the larger number, starting with the minimal values between them.
-- There might be a larger pair that has a smaller difference between
-- them.

-- Scan for an answer with the larger number between Pa and Pb.
scan :: PInt -> PInt -> [(PInt, PInt)]
scan a b =
   -- Any two pentagonals will always sum to a value <= P(2*b).
   -- Pre-compute them so we can quickly search the space.
   let pmap = IntSet.fromAscList $ map pentagonal [1 .. 2 * b] in
   let isPent = (`IntSet.member` pmap) in
   [ (pj, pk) |
      j <- [ a + 1 .. b ],
      k <- [ 1 .. j - 1 ],
      let pj = pentagonal j,
      let pk = pentagonal k,
      isPent (pj + pk) && isPent (pj - pk) ]

-- Scan, given that we don't know the place of the answer.
solve1 :: PInt -> PInt
solve1 base = case scan base (8*base) of
   [] -> solve1 (8*base)
   ((a,b):_) -> a-b

solve :: PInt
solve = solve1 1
