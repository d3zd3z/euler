-- The 5-gon ring.
-- The description has some diagrams, which don't translate all that
-- well.
-- Represent the input as a list of the values in the inner and outer
-- rings.
-- Conveniently, we don't have to worry about the 16/17 digit
-- difference, since when sorted lexicographically, the solutions with
-- two 10s all start with 1 or 2, and the solution will be larger.
----------------------------------------------------------------------
-- 6531031914842725

module Main where

import Data.List
import Data.Maybe

magic :: [Int] -> Maybe [Int]
magic [a,b,c,d,e,f,g,h,i,j] =
   let s = f + a + b in
   if s == g + b + c &&
      s == h + c + d &&
      s == i + d + e &&
      s == j + e + a &&
      f < g && f < h && f < i && f < j
      then Just [f,a,b, g,b,c, h,c,d, i,d,e, j,e,a]
      else Nothing
magic _ = Nothing

solve :: String
solve =
   let possible = catMaybes $ map magic $ permutations [1..10] in
   concat $ map show $ maximum possible

main :: IO ()
main = putStrLn solve
