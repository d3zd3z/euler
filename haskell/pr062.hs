----------------------------------------------------------------------
-- The cube, 41063625 (3453), can be permuted to produce two other
-- cubes: 56623104 (3843) and 66430125 (4053). In fact, 41063625 is
-- the smallest cube which has exactly three permutations of its
-- digits which are also cube.
--
-- Find the smallest cube for which exactly five permutations of its
-- digits are cube.
--
-- Answer: 127035954683
----------------------------------------------------------------------

module Main where

import Data.List (sort)
import qualified Data.Map as Map
import Data.Map (Map)

main :: IO ()
main = putStrLn $ show $ solve 5

solve :: Int -> Integer
solve len = getSolution $ scanl (update len) emptyWork [ n^(3::Int) | n <- [1..] ]
  where
    getSolution :: [Work] -> Integer
    getSolution (Working _ : xs) = getSolution xs
    getSolution (Solved ans : _) = ans
    getSolution [] = error "Past end"

data Work
  = Working (Map String [Integer])
  | Solved Integer
  deriving Show

emptyWork :: Work
emptyWork = Working (Map.empty)

--  Add a new value to the work set.
update :: Int -> Work -> Integer -> Work
update _ s@(Solved _) _ = s
update len (Working m) num =
  if length numbers == len then Solved $ last numbers
  else Working (Map.insert digits numbers m)
  where
    digits = sort $ show num
    numbers = num : Map.findWithDefault [] digits m
