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
import Data.Set (Set)

import Data.List (sortBy)
import Data.Ord (comparing)

main :: IO ()
main = do
  grid <- readGrid "matrix.txt"
  print $ dijkstra nexts81 grid

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

readGrid :: String -> IO (A.Array Node Int)
readGrid path = do
  rows <- lines <$> readFile path
  let grid = map (map read . deComma) rows
  let height = length grid
  let width = allValue $ map length grid
  return $ A.listArray ((1, 1), (height, width)) $ concat grid

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

-- Next mapping for the simple (problem 81) puzzle.
nexts81 :: Int -> Int -> Node -> [Node]
nexts81 height width (y, x)
  | x == 0 && y == 0          = [(1, 1)]
  | x == width && y == height = []
  | y == height               = [(y, x+1)]
  | x == width                = [(y+1, x)]
  | otherwise                 = [(y, x+1), (y+1, x)]

-- Problem 82 is from any left cell to any right, moving up, down or right.

-- Solve the graph using Dijkstra's algorithm.
dijkstra :: (Int -> Int -> Node -> [Node]) ->
            A.Array Node Int ->
            Int
dijkstra nexts weights = solve sums0 Set.empty
  where
    next = nexts height width
    (_, (height, width)) = A.bounds weights
    sums0 = Map.fromList $ ((0, 0), 0) : [ (x, maxBound) | x <- A.indices weights ]
    solve sums seen = case allEdges of
      [] -> sum
      _  -> solve (Map.delete node newSums) (Set.insert node $ seen)
      where
        ((node, sum) : _) = sortBy (comparing snd) $ Map.toList sums
        allEdges = next node
        edges = filter (not . flip Set.member seen) allEdges
        costs = map (weights A.!) edges
        getSum node cost = (node, min oldSum newSum)
          where
            oldSum = sums Map.! node
            newSum = sum + cost
        sumUpdate = Map.fromList $ zipWith getSum edges costs
        newSums = Map.union sumUpdate sums
