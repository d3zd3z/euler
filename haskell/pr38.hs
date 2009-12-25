----------------------------------------------------------------------
-- Take the number 192 and multiply it by each of 1, 2, and 3:
--
--     192 × 1 = 192
--     192 × 2 = 384
--     192 × 3 = 576
--
-- By concatenating each product we get the 1 to 9 pandigital,
-- 192384576. We will call 192384576 the concatenated product of 192
-- and (1,2,3)
--
-- The same can be achieved by starting with 9 and multiplying by 1,
-- 2, 3, 4, and 5, giving the pandigital, 918273645, which is the
-- concatenated product of 9 and (1,2,3,4,5).
--
-- What is the largest 1 to 9 pandigital 9-digit number that can be
-- formed as the concatenated product of an integer with (1,2, ... ,
-- n) where n > 1?
----------------------------------------------------------------------

module Main where

import Data.List (sort, sortBy)

main :: IO ()
main = print $ case head items of
   (nums, _, _) -> undigits nums

-- First, niave solution with no pre-thought.

groupProd :: Int -> [Int] -> [Int]
groupProd num mults = concatMap (reverse . digits) $ map (* num) mults

-- This tries way too many things.  The narrow choice (9000..9999) is
-- very very quick.
items :: [([Int], Int, [Int])]
items = sortBy (flip compare) $ filter isFull $
   [ (groupProd num mults, num, mults) |
      -- num <- [1 .. 99999],
      num <- [9000..9999],
      mults <- [[1..limit] | limit <- [2..9], num * limit <= 987654321] ]

isFull :: ([Int], a, b) -> Bool
isFull (ds, _, _) = sort ds == goal

-- Reversed digits of a number.
digits :: Int -> [Int]
digits = sort . dig where
   dig 0 = []
   dig n = (n `mod` 10) : dig (n `div` 10)

undigits :: [Int] -> Int
undigits = un 0
   where
      un x [] = x
      un x (n:ns) = un (x*10 + n) ns

goal :: [Int]
goal = [1..9]
