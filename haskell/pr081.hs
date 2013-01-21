----------------------------------------------------------------------
-- Problem 81
--
-- 22 October 2004
--
--
-- In the 5 by 5 matrix below, the minimal path sum from the top left
-- to the bottom right, by only moving to the right and down, is
-- indicated in bold red and is equal to 2427.
--
--     131 673 234 103 18
--     201 96  342 965 150
-- [b] 630 803 746 422 111 [b]
--     537 699 497 121 956
--     805 732 524 37  331
--
-- Find the minimal path sum, in matrix.txt (right click and 'Save Link
-- /Target As...'), a 31K text file containing a 80 by 80 matrix, from
-- the top left to the bottom right by only moving right and down.
--
-- Problems 82 and 83 are based on the same matrix, but have different
-- connectivity constraints through the data.  This program solves all
-- 3 problems.
----------------------------------------------------------------------
-- 81: 427337
-- 82: 260324
-- 83: 425185

module Main where

import Control.Applicative ((<$>))
import qualified Data.Array as A
import qualified Data.Map as Map
import Data.Map (Map)
import qualified Data.Set as Set

import Data.List (sortBy)
import Data.Ord (comparing)

main :: IO ()
main = do
  grid <- readGrid "matrix.txt"
  putStrLn $ "81: " ++ show (solve81 grid)
  putStrLn $ "82: " ++ show (solve82 grid)
  putStrLn $ "83: " ++ show (solve83 grid)

solve81 :: A.Array Node Int -> Int
solve81 = solver nexts81 Map.empty

solve82 :: A.Array Node Int -> Int
solve82 = solver nexts82 $ Map.singleton (-1,-1) 0

solve83 :: A.Array Node Int -> Int
solve83 = solver nexts83 Map.empty

-- Build a solver that takes a next-generating function, a mapping
-- used to augment the node to weight map, and the array of the nodes
-- themselves.
solver :: (Int -> Int -> Node -> [Node]) ->
          Map Node Int ->
          A.Array Node Int ->
          Int
solver nexts augment grid = dijkstra next weights
  where
    (_, (height, width)) = A.bounds grid
    next = nexts height width
    weights = Map.union augment $ Map.fromList $ A.assocs grid

type Node = (Int, Int)

-- Simple data, from the problem description
simple :: A.Array Node Int
simple = A.listArray ((1, 1), (height, width)) $ concat grid
  where
    height = length grid
    width = allValue $ map length grid
    grid = [
      [131, 673, 234, 103, 18],
      [201, 96, 342, 965, 150],
      [630, 803, 746, 422, 111],
      [537, 699, 497, 121, 956],
      [805, 732, 524, 37, 331]]

-- Read the grid from the problem statement.
readGrid :: String -> IO (A.Array Node Int)
readGrid path = do
  rows <- lines <$> readFile path
  let grid = map (map read . deComma) rows
  let height = length grid
  let width = allValue $ map length grid
  return $ A.listArray ((1, 1), (height, width)) $ concat grid

-- Break a string of comma separated values into a list of subsequences.
deComma :: String -> [String]
deComma "" = []
deComma s =
  let (l, s') = break (== ',') s in
  l : case s' of
    [] -> []
    (_:s'') -> deComma s''

-- Assures that the list all contains the same value, and returns it.
allValue :: Eq a => [a] -> a
allValue [] = error "No value"
allValue [x] = x
allValue (a:b:rest) | a == b  = allValue (b:rest)
allValue _ = error "Value mismatch"

-- Next mapping for the simple (problem 81) puzzle.  Each node points
-- to the node to the right and below, if that makes sense.  The lower
-- right node has no neighbor, and is the exit.
nexts81 :: Int -> Int -> Node -> [Node]
nexts81 height width (y, x)
  | x == 0 && y == 0          = [(1, 1)]
  | x == width && y == height = []
  | y == height               = [(y, x+1)]
  | x == width                = [(y+1, x)]
  | otherwise                 = [(y, x+1), (y+1, x)]

-- Problem 82 is from any left cell to any right, moving up, down or
-- right.  Cell (0, 0) is the starting cell, which leds to any in the
-- left column, and cell (-1, -1) is the faked right destination cell
-- (with a weight of zero).
nexts82 :: Int -> Int -> Node -> [Node]
nexts82 height width (y, x)
  | x == 0 && y == 0   = [(yy, 1) | yy <- [1..height]]
  | x == -1 && y == -1 = []
  | otherwise          = up ++ down ++ right
  where
    up    = [(y-1, x) | y > 1]
    down  = [(y+1, x) | y < height]
    right = [if x < width then (y, x+1) else (-1,-1)]

-- Problem 83 is from the upper right, to the lower left moving up,
-- down, left, or right.
nexts83 :: Int -> Int -> Node -> [Node]
nexts83 height width (y, x)
  | x == 0 && y == 0          = [(1, 1)]
  | x == width && y == width  = []
  | otherwise                 = up ++ down ++ left ++ right
  where
    up    = [(y-1, x) | y > 1]
    down  = [(y+1, x) | y < height]
    left  = [(y, x-1) | x > 1]
    right = [(y, x+1) | x < width]

-- The meat of all of this is this implementation of Dijkstra's
-- algorithm.  Performance seems to be about half that of benchmarks
-- with a mostly imperative solution in Scala.  Both would be improved
-- by storing the sums in a priority queue, which would avoid the need
-- for the sort.  However, the priority queue needs the ability to
-- adjust the priority of nodes already in the queue (moving them).
dijkstra :: (Node -> [Node]) ->
            Map Node Int ->
            Int
dijkstra next weights = solve sums0 Set.empty
  where
    sums0 = Map.fromList $ ((0, 0), 0) : [ (x, maxBound) | x <- Map.keys weights ]
    solve sums seen = case allEdges of
      [] -> nodeSum
      _  -> solve (Map.delete node newSums) (Set.insert node seen)
      where
        ((node, nodeSum) : _) = sortBy (comparing snd) $ Map.toList sums
        allEdges = next node
        edges = filter (not . flip Set.member seen) allEdges
        costs = map (weights Map.!) edges
        getSum nd cost = (nd, min oldSum newSum)
          where
            oldSum = sums Map.! nd
            newSum = nodeSum + cost
        sumUpdate = Map.fromList $ zipWith getSum edges costs
        newSums = sumUpdate `Map.union` sums
