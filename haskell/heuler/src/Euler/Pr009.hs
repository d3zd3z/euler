----------------------------------------------------------------------
-- A Pythagorean triplet is a set of three natural numbers, a < b < c,
-- for which,
-- a^(2) + b^(2) = c^(2)
--
-- For example, 3^(2) + 4^(2) = 9 + 16 = 25 = 5^(2).
--
-- There exists exactly one Pythagorean triplet for which a + b + c =
-- 1000.
-- Find the product abc.

module Euler.Pr009 (pr009) where

import Euler.Problem

pr009 :: Problem
pr009 = Problem { prNumber = 9, prOp = return trips, prCorrect = 31875000 }

trips :: Int
trips = head [ a*b*c | a <- [1..997], b <- [a + 1 .. 997],
   let c = 1000-a-b,
   c > b,
   a^2 + b^2 == c^2 ]
