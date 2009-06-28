----------------------------------------------------------------------
-- Let d(n) be defined as the sum of proper divisors of n (numbers
-- less than n which divide evenly into n).
-- If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable
-- pair and each of a and b are called amicable numbers.
--
-- For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20,
-- 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of
-- 284 are 1, 2, 4, 71 and 142; so d(284) = 220.
--
-- Evaluate the sum of all the amicable numbers under 10000.
----------------------------------------------------------------------

module Main where

import Data.List (group)

main :: IO ()
main = print $ sum $ filter isAmicable [2..10000]

isAmicable :: Int -> Bool
isAmicable x = pair /= x && pairOf pair == x
   where pair = pairOf x

pairOf :: Int -> Int
pairOf x = sum . filter (< x) . divisors $ x

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
isPrime n = filter (\x -> n `mod` x == 0) factors == []
   where
      factors = takeWhile (<= (floor $ sqrt $ fromIntegral n)) primes
