----------------------------------------------------------------------
-- The decimal number, 585 = 1001001001_(2) (binary), is palindromic
-- in both bases.
--
-- Find the sum of all numbers, less than one million, which are
-- palindromic in base 10 and base 2.
--
-- (Please note that the palindromic number, in either base, may not
-- include leading zeros.)
----------------------------------------------------------------------

module Main where

main :: IO ()
main = print $ sum [ x | x <- [1,3..999999], palindromic 2 x, palindromic 10 x ]

palindromic :: Int -> Int -> Bool
palindromic base n = num == reverse num
   where num = digits base n

digits :: Int -> Int -> [Int]
digits _ 0 = []
digits base n = (n `mod` base) : digits base (n `div` base)
