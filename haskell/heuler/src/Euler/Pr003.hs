module Euler.Pr003 (pr003) where

import Euler.Problem
import Euler.Primes (lazyPrimes)

pr003 :: Problem
pr003 = Problem { prNumber = 3, prOp = return solution, prCorrect = 6857 }

solution :: Integer
solution = solve num lazyPrimes
   where
      num = 600851475143
      solve :: Integer -> [Integer] -> Integer
      solve 1 (p:_) = p
      solve n (p:ps) =
         if n `mod` p == 0
            then solve (n `div` p) (p:ps)
            else solve n ps
      solve _ [] = undefined
