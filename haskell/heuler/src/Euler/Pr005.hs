----------------------------------------------------------------------
-- 2520 is the smallest number that can be divided by each of the
-- numbers from 1 to 10 without any remainder.
--
-- What is the smallest number that is evenly divisible by all of the
-- numbers from 1 to 20?

module Euler.Pr005 (pr005) where

import Euler.Problem
import Data.List (foldl1')

pr005 :: Problem
pr005 = Problem { prNumber = 5, prOp = return solution, prCorrect = 232792560 }

solution :: Int
solution = foldl1' lcm [1 .. 20]
