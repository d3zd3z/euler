----------------------------------------------------------------------
-- The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
--
-- Find the sum of all the primes below two million.

-- Note that this overflows on a 32-bit machine.

module Main where

import qualified Primes

main :: IO ()
main = print answer

answer :: Int
answer = sum $ takeWhile (< 2000000) Primes.lazyPrimes

primes :: [Int]
primes = 2 : 3 : [x | x <- [5..], isPrime x]

isPrime :: Int -> Bool
isPrime n = filter (\x -> n `mod` x == 0) factors == []
   where
      factors = takeWhile (<= (floor $ sqrt $ fromIntegral n)) primes
