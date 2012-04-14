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

import Data.Functor

data Node = Node { nodeValue :: Int, nodeNext :: [Node] }
--           deriving Show
-- Not sure how useful Show really is, since it kind of explodes.

-- Interesting, but not really very useful
makeGraph :: [[Int]] -> Node
makeGraph lines = case nodeList of
  ((n:_):_) -> n
  _ -> error "No nodes"
  where nodeList = vconnect $ map listToNode lines

-- Make nodes out of a single line.
listToNode :: [Int] -> [Node]
listToNode [] = []
listToNode (a:as) = node : rest
  where node = Node { nodeValue = a, nodeNext = next }
        rest = listToNode as
        next = case rest of
          [] -> []
          (n:_) -> [n]

vconnect :: [[Node]] -> [[Node]]
vconnect [] = []
vconnect [a] = [a]
vconnect (a:b:bs) = anodes : vconnect (b:bs)
  where anodes = zipWith connect a b
        connect a b = a { nodeNext = b : nodeNext a }

-- Read the matrix in.
getMatrix :: FilePath -> IO [[Int]]
getMatrix path = do
  text <- lines <$> readFile path
  return $ map ((map read) . split (==',')) text

sample :: [[Int]]
sample = [
  [131, 673, 234, 103, 18],
  [201, 96, 342, 965, 150],
  [630, 803, 746, 422, 111],
  [537, 699, 497, 121, 956],
  [805, 732, 524, 37, 331]]

split :: (a -> Bool) -> [a] -> [[a]]
split _ [] = []
split t s =
  let (l, s') = break t s in
  l : case s' of
    [] -> []
    (_:s'') -> split t s''
