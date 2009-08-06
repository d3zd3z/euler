----------------------------------------------------------------------
-- Various utilities associated with prime numbers.

module Primes where

import Data.List (group)

-- Not necessarily in order.
divisors :: Int -> [Int]
divisors = spread . primeFactors

spread :: [(Int, Int)] -> [Int]
spread [] = [1]
spread ((p,count):r) = 
   [ res * p^x |
      res <- spread r,
      x <- [0..count] ]

primeFactors :: Int -> [(Int, Int)]
primeFactors n = map (\x -> (head x, length x)) (group answer)
   where
      answer = seek n primes
      seek 1 _ = []
      seek x fs@(f:fr)
         | x `mod` f == 0   = f : seek (x `div` f) fs
         | f > x            = error "Factoring coding error"
         | otherwise        = seek x fr

primes :: [Int]
primes = 2 : 3 : [x | x <- [5..], isPrime x]

isPrime :: Int -> Bool
isPrime n = n > 1 && filter (\x -> n `mod` x == 0) factors == []
   where
      factors = takeWhile (<= (floor $ sqrt $ fromIntegral n)) primes

-- Horrible solution, but interesting in it's simplicity.
primes2 :: [Int]
primes2 = sieve [2..]
   where
      sieve (p:x) = p : sieve [ n | n <- x, n `mod` p > 0 ]
