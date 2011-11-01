-- Continued fraction representation of 'e'.

module Main where

import Data.Ratio
import Data.List
import Nums

-- Resolve a partial fraction
{-
-- Silly to make all 1/x.
resolve' :: [Integer] -> Ratio Integer
resolve' [a] = 1 % a
resolve' (a:as) = 1 / (a%1 + resolve' as)

resolve xs = 1 / resolve' xs
-}

resolve :: [Integer] -> Ratio Integer
resolve [a] = a%1
resolve (a:as) = a%1 + 1/(resolve as)

{-
efrac :: [Int]
efrac = 2 : seq 1 where
   seq n = [1, 2*n, 1] ++ seq (n+1)
-}

-- Or a simpler version.
efrac :: [Integer]
efrac = 2 : concat [ [1,2*i,1] | i <- [1..] ]

solve :: Int
solve = sum $ digits $ numerator $ resolve $ take 100 efrac

main :: IO ()
main = print solve
