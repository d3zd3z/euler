module Main where

main :: IO ()
main = do
   print $ nums
   where
      nums = sum [x | x <- takeWhile (< 4000000) fibs, x `mod` 2 == 0]

fibs :: [Int]
fibs = fibgen 1 1

fibgen :: Int -> Int -> [Int]
fibgen a b = a : fibgen b (a+b)
