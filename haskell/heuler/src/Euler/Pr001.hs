module Euler.Pr001 where

import Euler.Problem

pr001 :: Problem
pr001 = Problem { prNumber = 1, prOp = return pr1, prCorrect = 233168 }

pr1 :: Int
pr1 = sum [x | x <- [1..999], x `divides` 3 || x `divides` 5]

divides :: Int -> Int -> Bool
a `divides` b = a `mod` b == 0
