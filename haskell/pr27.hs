----------------------------------------------------------------------
-- Euler published the remarkable quadratic formula:
--
-- n² + n + 41
--
-- It turns out that the formula will produce 40 primes for the
-- consecutive values n = 0 to 39. However, when n = 40, 40^(2) + 40 +
-- 41 = 40(40 + 1) + 41 is divisible by 41, and certainly when n = 41,
-- 41² + 41 + 41 is clearly divisible by 41.
--
-- Using computers, the incredible formula  n² − 79n + 1601 was
-- discovered, which produces 80 primes for the consecutive values n =
-- 0 to 79. The product of the coefficients, −79 and 1601, is −126479.
--
-- Considering quadratics of the form:
--
--     n² + an + b, where |a| < 1000 and |b| < 1000
--
--     where |n| is the modulus/absolute value of n
--     e.g. |11| = 11 and |−4| = 4
--
-- Find the product of the coefficients, a and b, for the quadratic
-- expression that produces the maximum number of primes for
-- consecutive values of n, starting with n = 0.
----------------------------------------------------------------------

module Main where

import Primes

main :: IO ()
main = case maximum answer of
   (count, a, b) -> print (a * b)

answer = [ (nPrimes a b 0, a, b) |
   a <- [-999 .. -1] ++ [1 .. 999],
   b <- [-999 .. -1] ++ [1 .. 999] ]

nPrimes :: Int -> Int -> Int -> Int
nPrimes a b n
   | num > 0 && isPrime num  = nPrimes a b (n+1)
   | otherwise               = n
      where num = n^2 + a*n + b
