----------------------------------------------------------------------
-- Problem 77
--
-- 27 August 2004
--
--
-- It is possible to write ten as the sum of primes in exactly five different
-- ways:
--
-- 7 + 3
-- 5 + 5
-- 5 + 3 + 2
-- 3 + 3 + 2 + 2
-- 2 + 2 + 2 + 2 + 2
--
-- What is the first value which can be written as the sum of primes in over
-- five thousand different ways?
----------------------------------------------------------------------
-- 71

module Main where

import Nums
import Data.List

-- Code assumes that the primes are in increasing order.
sumCount :: Int -> [Int] -> Int
sumCount _ [] = 0
sumCount n allp@(p:ps)
   | n == p = 1
   | n < p  = 0   -- Assumes: all (>p) ps
   | otherwise =
      sumCount (n-p) allp + sumCount n ps

countup :: Int -> Int
countup n = sumCount n $ takeWhile (<=n) primes

solve :: Int
solve =
   case [ (x, c) | x <- [2..], let c = countup x, c >= 5000 ] of
      ((n, _):_) -> n
      [] -> error "Didn't find solution"

main :: IO ()
main = print solve
