----------------------------------------------------------------------
-- The n^(th) term of the sequence of triangle numbers is given by,
-- t_(n) = ½n(n+1); so the first ten triangle numbers are:
--
-- 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
--
-- By converting each letter in a word to a number corresponding to
-- its alphabetical position and adding these values we form a word
-- value. For example, the word value for SKY is 19 + 11 + 25 = 55 =
-- t_(10). If the word value is a triangle number then we shall call
-- the word a triangle word.
--
-- Using words.txt (right click and 'Save Link/Target As...'), a 16K
-- text file containing nearly two-thousand common English words, how
-- many are triangle words?
----------------------------------------------------------------------

module Main where

import Data.Char (ord)

main :: IO ()
main = do
   w <- wordList
   print $ length $ filter isTriangle $ map wordValue w

triangles :: [Int]
triangles = gen 0 1
   where
      gen alast n = alast+n : gen (alast+n) (n+1)

isTriangle :: Int -> Bool
isTriangle num = t triangles
   where
      t (x:xs)
         | x == num = True
         | x > num = False
         | otherwise = t xs
      t [] = error "Out of infinite numbers"

wordValue :: String -> Int
wordValue = sum . map ((subtract 64) . ord)

wordList :: IO [String]
wordList = do
   allWords <- readFile "words.txt"
   return . split (== ',') . filter (/= '\"') $ allWords

split :: (a -> Bool) -> [a] -> [[a]]
split _ [] = []
split t s =
   let (l, s') = break t s
   in
      l : case s' of
            [] -> []
            (_:s'') -> split t s''
