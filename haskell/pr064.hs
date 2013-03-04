-- Problem 64.
-- Find length of continued fraction cycle for various sqrts.

module Main where

import Nums (isqrt)

-- Generate the continued series for a square root.  Simple square
-- roots always repeat starting from the first fractional value, which
-- makes things a bit easier.
sqrtSeries :: Int -> [Int]
sqrtSeries s =
   a0 : steps m1 d1 a1
   where
      a0 = isqrt s
      first@(m1, d1, a1) = step 0 1 a0
      step m d a =
         let m' = d*a - m in
         let d' = (s - (m' ^ (2::Int))) `div` d in
         let a' = (a0 + m') `div` d' in
         (m', d', a')

      steps _ 0 _ = []
      steps m d a =
         let this@(m', d', a') = step m d a in
         if this == first then [a]
            else a : steps m' d' a'

sqrtLen :: Int -> Int
sqrtLen = length . drop 1 . sqrtSeries

solve :: Int
solve = length $ filter odd $ map sqrtLen [1 .. 10000]

main :: IO ()
main = print solve
