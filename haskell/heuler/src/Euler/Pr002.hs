module Euler.Pr002 (pr002) where

import Euler.Problem

pr002 :: Problem
pr002 = Problem { prNumber = 2, prOp = return nums, prCorrect = 4613732 }

nums :: Int
nums = sum [x | x <- takeWhile (< 4000000) fibs, x `mod` 2 == 0]

fibs :: [Int]
fibs = fibgen 1 1

fibgen :: Int -> Int -> [Int]
fibgen a b = a : fibgen b (a+b)
