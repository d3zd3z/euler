----------------------------------------------------------------------
-- Problem 75
--
-- 30 July 2004
--
-- It turns out that 12 cm is the smallest length of wire that can be bent to form
-- an integer sided right angle triangle in exactly one way, but there are many
-- more examples.
--
-- 12 cm: (3,4,5)
-- 24 cm: (6,8,10)
-- 30 cm: (5,12,13)
-- 36 cm: (9,12,15)
-- 40 cm: (8,15,17)
-- 48 cm: (12,16,20)
--
-- In contrast, some lengths of wire, like 20 cm, cannot be bent to form an
-- integer sided right angle triangle, and other lengths allow more than one
-- solution to be found; for example, using 120 cm it is possible to form exactly
-- three different integer sided right angle triangles.
--
-- 120 cm: (30,40,50), (20,48,52), (24,45,51)
--
-- Given that L is the length of the wire, for how many values of L ≤ 1,500,000
-- can exactly one integer sided right angle triangle be formed?
----------------------------------------------------------------------

module Main where

import Data.List

-- The performance of these is a wash.
-- And it doesn't matter any way, since there is a nice generator for
-- the triples.
isqrt :: Int -> Int
isqrt = floor . sqrt . fromIntegral

myisqrt :: Int -> Int
myisqrt n = scan n where
   scan x =
      let x2 = (x + n `div` x) `div` 2 in
      if x == x2 then x
         else scan x2

data Box = Box !Int !Int !Int !Int
   deriving (Show)

startBox :: Box
startBox = Box 1 1 2 3

children :: Box -> [Box]
children (Box p1 p2 q1 q2) =
   let x = p2 in
   let y = q2 in
   [Box (y - x) x y (y * 2 - x),
    Box x y (x + y) (x * 2 + y),
    Box y x (y + x) (y * 2 + x)]

triangle :: Box -> (Int, Int, Int)
triangle (Box p1 p2 q1 q2) =
   (q1 * p1 * 2, p2 * q2, p1 * q2 + p2 * q1)

triangleTimes :: (Int, Int, Int) -> Int -> (Int, Int, Int)
triangleTimes (a,b,c) x = (a*x, b*x, c*x)

circumference :: (Int, Int, Int) -> Int
circumference (x,y,z) = x+y+z

-- Generate the primitive triples.
primitiveTriples :: Int -> [(Int, Int, Int)]
primitiveTriples limit = walk startBox where
   walk b1 =
      let t1 = triangle b1 in
      if circumference t1 > limit then []
         else
            let ch = children b1 in
            triangle b1 : concatMap walk ch

triples :: Int -> [(Int, Int, Int)]
triples limit =
   [ t |
      prim <- primitiveTriples limit,
      t <- takeWhile (\tr -> circumference tr <= limit)
            [ triangleTimes prim k | k <- [1..] ] ]

solve :: Int
solve =
   length $ filter (\x -> length x == 1) $ group $ sort $ map circumference $ triples 1500000

main :: IO ()
main = print solve
