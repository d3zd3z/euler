----------------------------------------------------------------------
-- If the numbers 1 to 5 are written out in words: one, two, three,
-- four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in
-- total.
--
-- If all the numbers from 1 to 1000 (one thousand) inclusive were
-- written out in words, how many letters would be used?
--
-- NOTE: Do not count spaces or hyphens. For example, 342 (three
-- hundred and forty-two) contains 23 letters and 115 (one hundred and
-- fifteen) contains 20 letters. The use of "and" when writing out
-- numbers is in compliance with British usage.
----------------------------------------------------------------------

module Main where

import Data.Array.IArray
import Data.List (intercalate)
import Data.Char (isLetter)

main :: IO ()
main = print answer
   where
      answer = length $ filter isLetter $ written
      written = intercalate ", " $ map spoken [1..1000]

smalls :: Array Int String
smalls = listArray (0,19) [
   "zero", "one", "two", "three", "four", "five", "six", "seven",
   "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen",
   "fifteen", "sixteen", "seventeen", "eighteen", "nineteen" ]

tens :: Array Int String
tens = listArray (2,9) [
   "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty",
   "ninety" ]

-- Generate spoken version, up to 1000 (as defined by the problem).
spoken :: Int -> String
spoken 1000 = "one thousand"
spoken n
   | n <= 0   = error "Unsupported number"
   | n < 20   = smalls ! n
   | n < 100 && n `mod` 10 == 0   = tens ! (n ` div` 10)
   | n < 100  = tens ! (n `div` 10) ++ "-" ++ smalls ! (n `mod` 10)
   | n < 1000 && n `mod` 100 == 0  = spoken (n `div` 100) ++ " hundred"
   | n < 1000 = spoken (n `div` 100) ++ " hundred and " ++ spoken (n `mod` 100)
