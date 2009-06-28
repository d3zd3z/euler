module Main where

main :: IO ()
main = do
   print $ show pr1

pr1 :: Int
pr1 = sum [x | x <- [1..999], x `divides` 3 || x `divides` 5]

divides :: Int -> Int -> Bool
a `divides` b = a `mod` b == 0
