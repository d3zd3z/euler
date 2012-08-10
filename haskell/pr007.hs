----------------------------------------------------------------------
-- By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we
-- can see that the 6^(th) prime is 13.
--
-- What is the 10001^(st) prime number?

module Main where

main :: IO ()
main = print answer
   where
      answer = primes !! 10000

primes :: [Integer]
primes = 2 : 3 : [x | x <- [5..], isPrime x]

isPrime :: Integer -> Bool
isPrime n = filter (\x -> n `mod` x == 0) factors == []
   where
      factors = takeWhile (<= (floor $ sqrt $ fromInteger n)) primes
