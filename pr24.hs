----------------------------------------------------------------------
-- A permutation is an ordered arrangement of objects. For example,
-- 3124 is one possible permutation of the digits 1, 2, 3 and 4. If
-- all of the permutations are listed numerically or alphabetically,
-- we call it lexicographic order. The lexicographic permutations of
-- 0, 1 and 2 are:
--
-- 012   021   102   120   201   210
--
-- What is the millionth lexicographic permutation of the digits 0, 1,
-- 2, 3, 4, 5, 6, 7, 8 and 9?
----------------------------------------------------------------------

module Main where

main :: IO ()
main = putStrLn $ (lexPerm ['0'..'9']) !! 999999

-- The haskell library's permutations function works, but doesn't
-- return the results in the right order.  Rather than sort them,
-- devise a permutation that returns them in the right order.

lexPerm :: [a] -> [[a]]
lexPerm [a] = [[a]]
lexPerm l = foldr pick [] [0..(length l - 1)]
   where
      pick pos acc = case splitAt pos l of
         (hd, (t:r)) -> map (t:) (lexPerm (hd ++ r)) ++ acc
         _ -> error "Pick past end"
