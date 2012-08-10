----------------------------------------------------------------------
-- It can be seen that the number, 125874, and its double, 251748,
-- contain exactly the same digits, but in a different order.
--
-- Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x,
-- and 6x, contain the same digits.
----------------------------------------------------------------------

module Main where

import Data.List (sort)

main :: IO ()
main = print $ head [x | x <- [1..], valid x]

valid :: Int -> Bool
valid n = all (== digits n) [ digits (n*x) | x <- [2..6] ]

digits :: Int -> [Int]
digits = sort . digits'
   where
      digits' 0 = []
      digits' n = (n `mod` 10) : digits' (n `div` 10)
