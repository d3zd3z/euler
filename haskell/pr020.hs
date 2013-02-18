----------------------------------------------------------------------
-- Find the sum of the digits in the number 100!
----------------------------------------------------------------------

module Main where

import Data.Char (digitToInt)

main :: IO ()
main = print answer

answer :: Int
answer = sum . map digitToInt . show . product $ [2 :: Integer .. 100]
