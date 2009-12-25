----------------------------------------------------------------------
-- 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
--
-- Find the sum of all numbers which are equal to the sum of the
-- factorial of their digits.
--
-- Note: as 1! = 1 and 2! = 2 are not sums they are not included.
----------------------------------------------------------------------

module Main where

import Data.Char (digitToInt)
import Data.Array

main :: IO ()
main = print $ sum $ [ n | n <- [10..limit], factOfDigits n == n ]

-- Largest possible solution is 7*9!, since 8*9! is only a 7 digit
-- number.
limit :: Int
limit = 7 * fact 9

-- 'show' is actually quite a bit faster since the library show code is
-- hand optimized.
factOfDigits :: Int -> Int
factOfDigits n = sum $ map fact $ digits n []
-- factOfDigits = sum . map (fact . digitToInt) . show

-- digits :: Int -> [Int]
-- digits 0 = []
-- digits n = (n `mod` 10) : digits (n `div` 10)

digits :: Int -> [Int] -> [Int]
digits x cs
   | x < 10 = x : cs
   | otherwise =
      case x `mod` 10 of
	 c -> digits (x `div` 10) (c : cs)

fact :: Int -> Int
fact = (!) (listArray (0 :: Int, 9) [ product [2..n] | n <- [0..9] ])
