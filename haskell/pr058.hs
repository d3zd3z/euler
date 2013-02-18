----------------------------------------------------------------------
-- Starting with 1 and spiralling anticlockwise in the following way,
-- a square spiral with side length 7 is formed.
--
-- 37 36 35 34 33 32 31
-- 38 17 16 15 14 13 30
-- 39 18  5  4  3 12 29
-- 40 19  6  1  2 11 28
-- 41 20  7  8  9 10 27
-- 42 21 22 23 24 25 26
-- 43 44 45 46 47 48 49
--
-- It is interesting to note that the odd squares lie along the bottom
-- right diagonal, but what is more interesting is that 8 out of the
-- 13 numbers lying along both diagonals are prime; that is, a ratio
-- of 8/13 ≈ 62%.
--
-- If one complete new layer is wrapped around the spiral above, a
-- square spiral with side length 9 will be formed. If this process is
-- continued, what is the side length of the square spiral for which
-- the ratio of primes along both diagonals first falls below 10%?
----------------------------------------------------------------------

module Main where

import Nums

diagonals :: [Int]
diagonals = 1 : step 1 increments where
   step n (s:ss) = let n' = n+s in n' : step n' ss
   step _ _ = error "Shouldn't happen"
   increments = concatMap (replicate 4) [2, 4 ..]

ratios :: [(Int, Int)]
ratios = (1, 0) : ns 1 0 (drop 1 diagonals) where
   ns total prime (a:as) =
      let ratio@(t2, p2) = (total+1, if isPrime a then prime+1 else prime) in
      ratio : ns t2 p2 as
   ns _ _ [] = undefined

-- Take only the groups that are actually complete squares.
takeBlocks :: [a] -> [a]
takeBlocks (a:as) = a : takeMore as where
   takeMore (_:_:_:x:xs) = x : takeMore xs
   takeMore _ = undefined
takeBlocks [] = undefined

solution :: Int
solution =
   let ((count, _):_) = dropWhile (\ (a, b) -> a < 10*b) . drop 1 . takeBlocks $ ratios in
   (count - 1) `div` 2 + 1

main :: IO ()
main = print solution
