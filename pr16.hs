----------------------------------------------------------------------
-- 2^(15) = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
--
-- What is the sum of the digits of the number 2^(1000)?

module Main where

import Data.Char (digitToInt)

main :: IO ()
main = print answer

answer :: Int
answer = sum $ map digitToInt $ show ((2 :: Integer) ^ 1000)
