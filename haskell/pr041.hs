----------------------------------------------------------------------
-- We shall say that an n-digit number is pandigital if it makes use
-- of all the digits 1 to n exactly once. For example, 2143 is a
-- 4-digit pandigital and is also prime.
--
-- What is the largest n-digit pandigital prime that exists?
----------------------------------------------------------------------

module Main where

import Primes
import Data.List (permutations)

-- Conveniently, the largest pandigital number, period, fits in an
-- Int32.

main :: IO ()
main = print $ maximum pprimes

pprimes :: [Int]
pprimes = [ num |
   n <- [1..9],
   digits <- permutations [1..n],
   let num = undigits digits,
   isPrime num ]

-- Undigitify a list of digits.  Done right-to-left, but since we use
-- all permutations, it doesn't matter.
undigits :: [Int] -> Int
undigits [] = 0
undigits (n:r) = n + (10 * undigits r)
