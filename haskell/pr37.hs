----------------------------------------------------------------------
-- The number 3797 has an interesting property. Being prime itself, it
-- is possible to continuously remove digits from left to right, and
-- remain prime at each stage: 3797, 797, 97, and 7. Similarly we can
-- work from right to left: 3797, 379, 37, and 3.
--
-- Find the sum of the only eleven primes that are both truncatable
-- from left to right and right to left.
--
-- NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
----------------------------------------------------------------------

module Main where

import Primes
import Data.List (tails)

main :: IO ()
main = print $ sum $ take 11 bothPrimes

bothPrimes :: [Int]
bothPrimes = [ x | x <- [11..], rightPrime x, leftPrime x ]

rightPrime :: Int -> Bool
rightPrime 0 = True
rightPrime n = isPrime n && rightPrime (n `div` 10)

leftPrime :: Int -> Bool
leftPrime = all isPrime . map read . init . tails . show
