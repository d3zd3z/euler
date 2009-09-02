----------------------------------------------------------------------
-- It was proposed by Christian Goldbach that every odd composite
-- number can be written as the sum of a prime and twice a square.
--
-- 9 = 7 + 2×1^(2)
-- 15 = 7 + 2×2^(2)
-- 21 = 3 + 2×3^(2)
-- 25 = 7 + 2×3^(2)
-- 27 = 19 + 2×2^(2)
-- 33 = 31 + 2×1^(2)
--
-- It turns out that the conjecture was false.
--
-- What is the smallest odd composite that cannot be written as the
-- sum of a prime and twice a square?
----------------------------------------------------------------------

module Main where

import Primes
import Data.Maybe (catMaybes)

main :: IO ()
main = print answer

answer :: Int
answer = head $ catMaybes $ map want src

src :: [Int]
src = [ n | n <- [9,11..], not $ isPrime n ]

want :: Int -> Maybe Int
want n = case gold n of
   [] -> Just n
   _ -> Nothing

gold :: Int -> [(Int, Int)]
gold n = [ (p, s) |
   p <- takeWhile (< n) primes,
   s <- [1 .. p-1],
   n == p + 2*s*s ]
