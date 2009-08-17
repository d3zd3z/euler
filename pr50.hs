----------------------------------------------------------------------
-- The prime 41, can be written as the sum of six consecutive primes:
-- 41 = 2 + 3 + 5 + 7 + 11 + 13
--
-- This is the longest sum of consecutive primes that adds to a prime
-- below one-hundred.
--
-- The longest sum of consecutive primes below one-thousand that adds
-- to a prime, contains 21 terms, and is equal to 953.
--
-- Which prime, below one-million, can be written as the sum of the
-- most consecutive primes?
----------------------------------------------------------------------

module Main where

import Primes
import Data.IntSet (IntSet)
import Data.List (tails, inits, sort)
import qualified Data.IntSet as IntSet

main :: IO ()
main = print answer

answer :: (Int, Int)
answer = last $ sort $ concatMap (primeSum 0 0) $ tails nums

limit :: Int
limit = 1000000

nums :: [Int]
nums = takeWhile (< limit) primes
-- nums = takeWhile (< 1000) primes

-- Quick memoized check for primality.
fastCheck :: Int -> Bool
fastCheck = flip IntSet.member $ IntSet.fromList nums

-- Seeded with an initial count and sum, and a list, return the
-- subsequences that produce a prime, returning the count, and the
-- prime itself.  Should be called as 'primeSum 0 0 items'.
primeSum :: Int -> Int -> [Int] -> [(Int, Int)]
primeSum count sum [] = []
primeSum count sum (a:as)
   | sum+a >= limit      = []
   | fastCheck (sum+a)  = (count+1, sum+a) : next
   | otherwise = next
      where next = primeSum (count+1) (sum+a) as
