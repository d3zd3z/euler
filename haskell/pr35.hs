----------------------------------------------------------------------
-- The number, 197, is called a circular prime because all rotations
-- of the digits: 197, 971, and 719, are themselves prime.
--
-- There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17,
-- 31, 37, 71, 73, 79, and 97.
--
-- How many circular primes are there below one million?
----------------------------------------------------------------------

module Main where

import Data.List (inits, tails)
import Primes

-- Note this isn't all that efficient, since '5' by itself is the only
-- number that can be included, since any other 5 in the number would
-- make it divisible by five.
--
-- We gain a lot by testing for primeness first before computing the
-- cycles, and testing them.
main :: IO ()
main = print $ length $ [ x | x <- [2..999999], isPrime x, isCirclePrime x ]

isCirclePrime :: Int -> Bool
isCirclePrime = all isPrime . map undigits . circles . digits

digits :: Int -> [Int]
digits 0 = []
digits n = (n `mod` 10) : digits (n `div` 10)

undigits :: [Int] -> Int
undigits = un 1
   where
      un _ [] = 0
      un m (n:ns)  = m*n + un (m*10) ns

circles :: [a] -> [[a]]
circles l = tail $ zipWith (++) (tails l) (inits l)
