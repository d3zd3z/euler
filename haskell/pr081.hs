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
--
--     201 96  342 965 150
--
-- [b] 630 803 746 422 111 [b]
--
--     537 699 497 121 956
--
--     805 732 524 37  331
--
-- Find the minimal path sum, in matrix.txt (right click and 'Save Link
-- /Target As...'), a 31K text file containing a 80 by 80 matrix, from
-- the top left to the bottom right by only moving right and down.
----------------------------------------------------------------------

module Main where

-- import Data.Functor
import Data.List (transpose, zipWith)
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Tuple (swap)
import Data.Set (Set)
import qualified Data.Set as Set
import qualified Data.Array as A

type Node = (Int, Int)
data Edge = Edge { edgeWeight :: Int, edgeNext :: Node }
          deriving Show

type EdgeMap = Map Node [Edge]

buildGraph :: [[Int]] -> EdgeMap
buildGraph matrix =
  foldl (Map.unionWith (++)) Map.empty [horiz, vert, entry]
  where horiz = horizontalEdges matrix
        vert = verticalEdges matrix
        entry = Map.singleton (0, 0) [Edge { edgeWeight = 0, edgeNext = (1, 1) }]

-- Add a single node to the map.
insertEdge :: Node -> Edge -> EdgeMap -> EdgeMap
insertEdge node edge = Map.insertWith (++) node [edge]

-- Given a matrix, generate edges (with weights) for the horizontal
-- connections.
makeEdges fixNode matrix =
  let oneRow rowNum row =
        let each colNum (a:b:rest) =
              let node = fixNode (rowNum, colNum) in
              let edge = Edge { edgeWeight = a, edgeNext = fixNode (rowNum, colNum+1) } in
              (node, [edge]) : each (colNum+1) (b:rest)
            each _ _ = [] in
        each 1 row in
  Map.fromList $ concat $ zipWith oneRow [1..] matrix

horizontalEdges :: [[Int]] -> EdgeMap
horizontalEdges = makeEdges id

verticalEdges :: [[Int]] -> EdgeMap
verticalEdges = makeEdges swap . transpose

-- Find all nodes mentioned by this graph that don't have any exits.
findExits :: EdgeMap -> Set Node
findExits edgeMap = Set.difference allNodes edgeNodes
  where edgeNodes = Set.fromList $ Map.keys edgeMap
        allNodes = Set.fromList $ map edgeNext $ concat $ Map.elems edgeMap

-- data Node = Node { nodeValue :: Int, nodeNext :: [Node] }
-- --           deriving Show
-- -- Not sure how useful Show really is, since it kind of explodes.
--
-- -- Interesting, but not really very useful
-- makeGraph :: [[Int]] -> Node
-- makeGraph lines = case nodeList of
--   ((n:_):_) -> n
--   _ -> error "No nodes"
--   where nodeList = vconnect $ map listToNode lines
--
-- -- Make nodes out of a single line.
-- listToNode :: [Int] -> [Node]
-- listToNode [] = []
-- listToNode (a:as) = node : rest
--   where node = Node { nodeValue = a, nodeNext = next }
--         rest = listToNode as
--         next = case rest of
--           [] -> []
--           (n:_) -> [n]
--
-- vconnect :: [[Node]] -> [[Node]]
-- vconnect [] = []
-- vconnect [a] = [a]
-- vconnect (a:b:bs) = anodes : vconnect (b:bs)
--   where anodes = zipWith connect a b
--         connect a b = a { nodeNext = b : nodeNext a }
--
-- -- Read the matrix in.
-- getMatrix :: FilePath -> IO [[Int]]
-- getMatrix path = do
--   text <- lines <$> readFile path
--   return $ map ((map read) . split (==',')) text
--
sample :: [[Int]]
sample = [
  [131, 673, 234, 103, 18],
  [201, 96, 342, 965, 150],
  [630, 803, 746, 422, 111],
  [537, 699, 497, 121, 956],
  [805, 732, 524, 37, 331]]

buildArray :: [[Int]] -> A.Array (Int, Int) Int
buildArray grid =
   A.listArray ((1, 1), (height, width)) $ concat grid
   where
      height = length sample
      width  = allValue $ map length sample

-- Given a 'width' and 'height' of the 1-based array, map a node into
-- a list of the 'next' nodes based on the problem description (down
-- and right).  The empty list result indicates the end of the graph.
nexts :: Int -> Int -> Node -> [Node]
nexts width height (x, y)
   | x == width && y == height  = []
   | y == height                = [(x+1, y)]
   | x == width                 = [(x, y+1)]
   | otherwise                  = [(x+1, y), (x, y+1)]

-- Assures that the list all contains the same value, and returns it.
allValue :: Eq a => [a] -> a
allValue [] = error "No value"
allValue [x] = x
allValue (a:b:rest) | a == b  = allValue (b:rest)
allValue _ = error "Value mismatch"

-- Dijkstra's algorithm, functionally.

-- State?
weight :: A.Array Node Int
weight = buildArray sample

next :: Node -> [Node]
next = nexts width height
   where
      (_, (width, height)) = A.bounds weight

distance :: Map Node Int
distance = Map.singleton (1,1) (weight A.! (1,1))

visited :: Set Node
visited = Set.empty

-- walk :: Node -> ()
walk here =
   (neighbors, ncosts)
   where
      neighbors = Set.toList $ Set.difference (Set.fromList $ next here) visited
      ncosts = map costOf neighbors
      myWeight  = distance Map.! here
      costOf node = myWeight + weight A.! node

data State = State {
}
