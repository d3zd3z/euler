----------------------------------------------------------------------
-- In England the currency is made up of pound, £, and pence, p, and
-- there are eight coins in general circulation:
--
--     1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
--
-- It is possible to make £2 in the following way:
--
--     1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
--
-- How many different ways can £2 be made using any number of coins?
----------------------------------------------------------------------

module Main where

main :: IO ()
main = print $ length $ solve 200 coins

coins :: [Int]
coins = [200, 100, 50, 20, 10, 5, 2, 1]

-- This only works when the last coin is 1.

solve :: Int -> [Int] -> [[(Int, Int)]]
solve 0 _ = [[]]
solve n (c:cs)
   | n < c = solve n cs
   | otherwise = concat [ map (coin t c) (solve (n-t*c) cs) | t <- [tries, tries-1 .. lower] ]
      where
         tries = n `div` c
         lower = if c == 1 then tries else 0
         coin 0 _ = id
         coin t c = ((t,c):)
solve _ [] = error "Implementation error"

-- TODO: Try this with list monad.
