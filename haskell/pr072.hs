----------------------------------------------------------------------
-- Problem 72
--
-- 18 June 2004
--
--
-- Consider the fraction, n/d, where n and d are positive integers. If n<d
-- and HCF(n,d)=1, it is called a reduced proper fraction.
--
-- If we list the set of reduced proper fractions for d ≤ 8 in ascending
-- order of size, we get:
--
-- 1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3,
-- 5/7, 3/4, 4/5, 5/6, 6/7, 7/8
--
-- It can be seen that there are 21 elements in this set.
--
-- How many elements would be contained in the set of reduced proper
-- fractions for d ≤ 1,000,000?
----------------------------------------------------------------------
-- 303963552391

module Main where

import Control.Exception (assert)
import Data.List
import Data.Ord
import Data.Ratio
import Nums

-- Let's do a couple of solutions.
-- First, naively, the answer is just the sum of the totients from 2
-- to 1 million.

totient :: Int -> Int
totient n =
   let factors = map fst $ primeFactors n in
   let answer = product $ n%1 : map (\x -> 1%1 - 1%x) factors in
   assert (denominator answer == 1) (numerator answer)

solve1 :: Integer
solve1 =
   sum [ fromIntegral $ totient x | x <- [2 .. 1000000] ]

-- Unfortunately, this is quite slow, since we have to factor every
-- number in order to compute the totient.  Since we are computing
-- every single number and all of the factors, we can compute them in
-- order.  This is a tradeoff of memory for speed.

-- Generate a not-very sorted list of numbers and their factors.
genFactors :: Int -> [(Int, Int)]
genFactors limit =
   [ (x, p) |
      p <- takeWhile (<= limit) primes,
      x <- [p, 2*p .. limit] ]

-- Combine the genFactors
combineFactors :: [(Int, Int)] -> [Int]
combineFactors nums =
   let clusters = groupBy (\a b -> fst a == fst b) $ sortBy (comparing fst) nums in
   let pairs = map (totientize . decluster) clusters in
   pairs

decluster :: [(Int, Int)] -> (Int, [Int])
decluster [] = error "Empty group"
decluster all@((n, _):_) =
   (n, map snd all)

totientize :: (Int, [Int]) -> Int
totientize (n, factors) =
   let answer = product $ n%1 : map (\x -> 1%1 - 1%x) factors in
   assert (denominator answer == 1) (numerator answer)

solve2 :: Integer
solve2 = sum $ map fromIntegral $ combineFactors $ genFactors 1000000

main :: IO ()
main = print solve2
