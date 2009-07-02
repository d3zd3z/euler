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

main :: IO ()
main = print $ sum $ [ n | n <- [10..limit], factOfDigits n == n ]

-- Largest possible solution is 7*9!, since 8*9! is only a 7 digit
-- number.
limit :: Int
limit = 7 * fact 9

-- The use of 'show', and the recomptuation of 'fact' makes this quite
-- a bit slower than it needs to be.
factOfDigits :: Int -> Int
factOfDigits = sum . map (fact . digitToInt) . show

fact :: Int -> Int
fact n = product [2..n]
