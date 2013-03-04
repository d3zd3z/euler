----------------------------------------------------------------------
-- There are exactly ten ways of selecting three from five, 12345:
--
-- 123, 124, 125, 134, 135, 145, 234, 235, 245, and 345
--
-- In combinatorics, we use the notation, ^(5)C_(3) = 10.
--
-- In general,
-- ^(n)C_(r) =
-- n!
--
-- r!(n−r)!, where r ≤ n, n! = n×(n−1)×...×3×2×1, and 0! = 1.
--
-- It is not until n = 23, that a value exceeds one-million:
-- ^(23)C_(10) = 1144066.
--
-- How many, not necessarily distinct, values of  ^(n)C_(r), for
-- 1 ≤ n ≤ 100, are greater than one-million?
----------------------------------------------------------------------
-- 4075

module Main where

main :: IO ()
-- main = print $ length $ filter (> 1000000) combos
main = print $ solve 101

combos :: [Integer]
combos = [ choose n r | n <- [23 .. 100], r <- [1..n-1] ]

choose :: Integer -> Integer -> Integer
choose n r = product [(n-r)+1 .. n] `div` product [1..r]

solve :: Int -> Int
solve count = length $ filter (==SatOverflow) $ concat $ take count items
  where
    items = iterate pascalNext [SatNormal 1]

-- An alternate solution is to compute the pascal's triangle until 101
-- rows, and determine how many overflows there are.  This is more
-- code, but runs a lot faster, since the numbers saturate before
-- becoming bignums.
data SatNum
     = SatNormal Int
     | SatOverflow
     deriving (Show, Eq)

satAdd :: SatNum -> SatNum -> SatNum
satAdd SatOverflow _ = SatOverflow
satAdd _ SatOverflow = SatOverflow
satAdd (SatNormal a) (SatNormal b) =
  let ab = a + b in
  if ab <= 1000000 then SatNormal ab
  else SatOverflow

pascalNext :: [SatNum] -> [SatNum]
pascalNext xs@(x:_) = x : next xs
  where
    next (a: (bs@(b:_))) = a `satAdd` b : next bs
    next [a] = [a]
    next [] = []
pascalNext [] = [SatNormal 1]
