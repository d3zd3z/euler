module Main where

import Primes (lazyPrimes)

main :: IO ()
main = print answer
   where
      num = 600851475143
      allFactors = takeWhile (< (floor $ sqrt $ fromInteger num)) lazyPrimes
      answer = filter (\x -> num `mod` x == 0) allFactors

primes :: [Integer]
primes = 2 : 3 : [x | x <- [5..], isPrime x]

isPrime :: Integer -> Bool
isPrime n = filter (\x -> n `mod` x == 0) factors == []
   where
      factors = takeWhile (<= (floor $ sqrt $ fromInteger n)) primes
