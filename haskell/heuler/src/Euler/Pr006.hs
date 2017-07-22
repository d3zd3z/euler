module Euler.Pr006 (pr006) where

import Euler.Problem

pr006 :: Problem
pr006 = Problem { prNumber = 6, prOp = return answer, prCorrect = 25164150 }

answer :: Int
answer = a - b
   where
      a = (sum [1..100]) ^ 2
      b = sum (map (^ 2) [1..100])
