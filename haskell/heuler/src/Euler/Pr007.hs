----------------------------------------------------------------------
-- By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we
-- can see that the 6^(th) prime is 13.
--
-- What is the 10001^(st) prime number?

module Euler.Pr007 (pr007) where

import Euler.Problem

pr007 :: Problem
pr007 = Problem { prNumber = 7, prOp = return answer, prCorrect = 104743 }

answer :: Integer
answer = primes !! 10000

-- Classic prime generator.  Not very efficient as the numbers grow
-- larger.
primes :: [Integer]
primes = 2 : 3 : [x | x <- [5..], isPrime x]

isPrime :: Integer -> Bool
isPrime n = filter (\x -> n `mod` x == 0) factors == []
   where
      factors = takeWhile (<= (floor $ sqrt $ fromInteger n)) primes
