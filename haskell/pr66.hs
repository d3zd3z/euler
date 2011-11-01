----------------------------------------------------------------------
-- Problem 66
--
-- 26 March 2004
--
--
-- Consider quadratic Diophantine equations of the form:
--
-- x^2 – Dy^2 = 1
--
-- For example, when D=13, the minimal solution in x is 649^2 – 13×180^2 = 1.
--
-- It can be assumed that there are no solutions in positive integers when D is
-- square.
--
-- By finding minimal solutions in x for D = {2, 3, 5, 6, 7}, we obtain the
-- following:
--
-- 3^2 – 2×2^2 = 1
-- 2^2 – 3×1^2 = 1
-- 9^2 – 5×4^2 = 1
-- 5^2 – 6×2^2 = 1
-- 8^2 – 7×3^2 = 1
--
-- Hence, by considering minimal solutions in x for D ≤ 7, the largest x is
-- obtained when D=5.
--
-- Find the value of D ≤ 1000 in minimal solutions of x for which the largest
-- value of x is obtained.
----------------------------------------------------------------------
-- 661

module Main where

import Data.Ord
import Data.List
import Data.Ratio

-- The minimal solution to a Pell's equation will be the first term in
-- the continued fraction expansion of sqrt(D) that satisfies the
-- equation.

isqrt :: Integer -> Integer
isqrt = floor . sqrt . fromIntegral

isSqr :: Integer -> Bool
isSqr n = let q = isqrt n in q^2 == n

-- Generate the continued fraction rep of the sqrt.
sqrtSeries :: Integer -> [Integer]
sqrtSeries s =
   step 0 1 a0
   where
      a0 = isqrt s
      step m d a =
         let m' = d*a - m in
         let d' = (s - (m' ^ 2)) `div` d in
         let a' = (a0 + m') `div` d' in
         a : step m' d' a'

-- Resolve a (finite) continued fraction.
resolve :: [Integer] -> Ratio Integer
resolve [a] = a%1
resolve (a:as) = a%1 + 1/(resolve as)

-- Does the given ratio (x%y) solve the Pell equation for a given d.
isPell :: Integer -> Ratio Integer -> Bool
isPell d rat =
   let x = numerator rat in
   let y = denominator rat in
   x^2 - d*y^2 == 1

findX :: Integer -> Integer
findX d =
   let rats = map resolve $ drop 1 $ inits $ sqrtSeries d in
   case find (isPell d) rats of
      Just r -> numerator r
      Nothing -> error "Ran off unbounded list"

-- solve :: Integer
solve = maximumBy (comparing snd) [ (i, findX i) | i <- [2..1000], not (isSqr i) ]

main :: IO ()
main = print $ fst solve

-- Notes:
-- Apparently, according to Wolfram Mathworld on the Pell Equation,
-- this can be solved without actually computing the value.  There is
-- also a way of computing the convergence directly rather than
-- recomputing each step.
