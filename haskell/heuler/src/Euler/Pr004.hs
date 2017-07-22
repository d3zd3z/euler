-- A palindromic number reads the same both ways. The largest
-- palindrome made from the product of two 2-digit numbers is 9009 =
-- 91 × 99.
--
-- Find the largest palindrome made from the product of two 3-digit
-- numbers.

module Euler.Pr004 (pr004) where

import Euler.Problem

import Data.List
import Data.Ord
import Euler.Nums

pr004 :: Problem
pr004 = Problem { prNumber = 4, prOp = return solution, prCorrect = 906609 }

isPalindrome :: Int -> Bool
isPalindrome x = x == revDigits x

solution :: Int
solution = 
   case maximumBy (comparing (\ (_, _, x) -> x)) pals of
      (_, _, answer) -> answer

pals :: [(Int, Int, Int)]
pals = [ (x, y, prod) | x <- [100..999], y <- [x..999],
         let prod = x * y,
         isPalindrome prod ]

-- Reverse the digits in the number.  Note that it doesn't terminate
-- if the number is negative.
revDigits :: Int -> Int
revDigits num = rev 0 num
   where
      rev accum 0 = accum
      rev accum n = rev (accum * 10 + n `mod` 10) (n `div` 10)
