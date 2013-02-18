----------------------------------------------------------------------
-- Starting with the number 1 and moving to the right in a clockwise
-- direction a 5 by 5 spiral is formed as follows:
--
-- 21 22 23 24 25
-- 20  7  8  9 10
-- 19  6  1  2 11
-- 18  5  4  3 12
-- 17 16 15 14 13
--
-- It can be verified that the sum of both diagonals is 101.
--
-- What is the sum of both diagonals in a 1001 by 1001 spiral formed
-- in the same way?
----------------------------------------------------------------------

module Main where

import Data.Array.IArray

main :: IO ()
main = print $ diagSum 500

data Dir = R | D | L | U
   deriving Show

diagSum :: Int -> Int
diagSum aspan = down + up - 1
   where
      ary = spiral aspan
      down = sum [ ary ! (x,x) | x <- [-aspan .. aspan] ]
      up = sum [ ary ! (x,-x) | x <- [-aspan .. aspan] ]

-- Construct a spiral in a grid 2*n+1 across with indices from
-- (-n,-n) to (n,n).
spiral :: Int -> Array (Int,Int) Int
spiral size = array ((-size, -size), (size, size)) $ take ((2*size+1) ^ (2::Int)) moves

moves :: [((Int,Int), Int)]
moves = moves' (0,0) spans dirs 1

-- Note that the (num+1) has to be strict to avoid building longer and
-- longer sequences of 1+1+1+1+1+1+... thunks for each term.
moves' :: (Int,Int) -> [Int] -> [Dir] -> Int -> [((Int,Int), Int)]
moves' pos (0:ns) (_:ds) num = moves' pos ns ds num
moves' pos (n:ns) (d:ds) num = (pos, num) : (moves' (move pos d) (n-1:ns) (d:ds) $! (num+1))
moves' _ [] _ _ = undefined
moves' _ _ [] _ = undefined

move :: (Int,Int) -> Dir -> (Int,Int)
move (x,y) R = (x+1,y)
move (x,y) D = (x,y+1)
move (x,y) L = (x-1,y)
move (x,y) U = (x,y-1)

dirs :: [Dir]
dirs = cycle [R, D, L, U]

spans :: [Int]
spans = 1 : 1 : 2 : 2 : (concat $ map (replicate 2) [3..])
