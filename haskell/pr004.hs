-- A palindromic number reads the same both ways. The largest
-- palindrome made from the product of two 2-digit numbers is 9009 =
-- 91 × 99.
--
-- Find the largest palindrome made from the product of two 3-digit
-- numbers.

module Main where

import Data.List
import Data.Ord
import Nums

main :: IO ()
main = putStrLn $ show solution

isPalindrome :: Eq a => [a] -> Bool
isPalindrome x = x == reverse x

solution :: (Int, Int, Int)
solution = maximumBy (comparing (\ (_, _, x) -> x)) pals

pals :: [(Int, Int, Int)]
pals = [ (x, y, prod) | x <- [100..999], y <- [x..999],
         let prod = x * y,
         isPalindrome $ digits prod ]
