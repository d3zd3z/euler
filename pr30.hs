----------------------------------------------------------------------
-- Surprisingly there are only three numbers that can be written as
-- the sum of fourth powers of their digits:
--
--     1634 = 1^(4) + 6^(4) + 3^(4) + 4^(4)
--     8208 = 8^(4) + 2^(4) + 0^(4) + 8^(4)
--     9474 = 9^(4) + 4^(4) + 7^(4) + 4^(4)
--
-- As 1 = 1^(4) is not a sum it is not included.
--
-- The sum of these numbers is 1634 + 8208 + 9474 = 19316.
--
-- Find the sum of all the numbers that can be written as the sum of
-- fifth powers of their digits.
----------------------------------------------------------------------

module Main where

import Data.Char (digitToInt)

main :: IO ()
main = print answer

-- If we look at n*9^5, we can quickly see that there cannot be a
-- 7-digit number that works.  So, only need to compute up to n=6.
answer = sum [ x | x <- [2..354294], sumPower 5 x == x ]

sumPower :: Int -> Int -> Int
sumPower pow = sum . map (^pow) . map digitToInt . show
