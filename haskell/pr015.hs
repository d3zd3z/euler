----------------------------------------------------------------------
-- Starting in the top left corner of a 2×2 grid, there are 6 routes
-- (without backtracking) to the bottom right corner.
--
-- How many routes are there through a 20×20 grid?
----------------------------------------------------------------------
-- Note that "without backtracking" means that the position always
-- moves in the positive direction, which makes this problem
-- reasonably solvable.

module Main where

-- import qualified Data.IntSet as S
import Data.Array.IArray

size :: Int
size = 20

-- I still don't like this, since it takes several minutes of CPU.
main :: IO ()
-- main = print $ [ (x,answer (2*x) 0, freedom x x) | x <- [2..20] ]
-- main = print $ [ (x, freedom x x) | x <- [2..15] ]
main = print $ free ! (size,size)

-- This solution assumes the grid is square.
-- Still quite slow.
-- answer :: Int -> Int -> Int
-- answer 0 0 = 1
-- answer 0 _ = 0
-- answer n x
--    | abs x > n   = 0
--    | otherwise  = answer (n-1) (x+1) + answer (n-1) (x-1)

-- freedom :: Int -> Int -> Int
-- freedom n 0 = 1
-- freedom 0 m = 1
-- freedom n m = freedom (n-1) m + freedom n (m-1)

-- Apparently, the answer is simply (40!)/(20! * 20!).

-- Memoized version of freedom.  Avoids lots of redundant computation,
-- and computes the answer quite quickly.
free :: Array (Int,Int) Int
free = array ((0,0),(size,size)) [ ((x,y), free' x y) | x <- [0..size], y <- [0..size] ]
   where
      free' _ 0 = 1
      free' 0 _ = 1
      free' n m = free ! (n-1,m) + free ! (n,m-1)

-- This takes several days to solve the problem.  However, without the
-- backtracking, there is no need to keep track of where we've been.
-- wide :: Int
-- high :: Int
-- wide = 2
-- high = 2
--
-- main :: IO ()
-- main = print $ length paths
-- 
-- key :: (Int,Int) -> Int
-- key (x,y) = x * 100 + y
-- 
-- inBounds :: (Int,Int) -> Bool
-- inBounds (x,y) = x >= 0 && y >= 0 && x <= wide && y <= high
-- 
-- valid :: S.IntSet -> (Int,Int) -> Bool
-- valid prior pos = inBounds pos && S.notMember (key pos) prior
-- 
-- paths :: [[(Int,Int)]]
-- paths = generate S.empty [] (0,0)
-- 
-- generate :: S.IntSet -> [(Int,Int)] -> (Int,Int) -> [[(Int,Int)]]
-- generate prior path pos@(x,y) = concat $ map next nodes
--    where
--       nodes = filter (valid prior) [(x+1,y), (x,y+1) {-, (x-1,y), (x,y-1)-} ]
--       next npos
--          | npos == (wide,high)   = [npos:path]
--          | otherwise             = generate (S.insert (key npos) prior) (npos:path) npos
