----------------------------------------------------------------------
-- Using names.txt (right click and 'Save Link/Target As...'), a 46K
-- text file containing over five-thousand first names, begin by
-- sorting it into alphabetical order. Then working out the
-- alphabetical value for each name, multiply this value by its
-- alphabetical position in the list to obtain a name score.
--
-- For example, when the list is sorted into alphabetical order,
-- COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name
-- in the list. So, COLIN would obtain a score of 938 × 53 = 49714.
--
-- What is the total of all the name scores in the file?
----------------------------------------------------------------------

module Main where

import Data.List (sort)
import Data.Char (ord)

main :: IO ()
main = do
   all <- names
   print $ answer all

answer :: [String] -> Int
answer = sum . zipWith (*) [1..] . map nameValue

nameValue :: String -> Int
nameValue = sum . map (\x -> ord x - ord 'A' + 1)

names :: IO [String]
names = do
   all <- readFile "names.txt"
   return . sort . split (== ',') . filter (/= '\"') $ all

split :: (a -> Bool) -> [a] -> [[a]]
split _ [] = []
split t s =
   let (l, s') = break t s
   in
      l : case s' of
            [] -> []
            (_:s'') -> split t s''
