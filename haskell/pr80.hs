----------------------------------------------------------------------
-- Problem 80
--
-- 08 October 2004
--
-- It is well known that if the square root of a natural number
-- is not an integer, then it is irrational. The decimal
-- expansion of such square roots is infinite without any
-- repeating pattern at all.
--
-- The square root of two is 1.41421356237309504880..., and the
-- digital sum of the first one hundred decimal digits is 475.
--
-- For the first one hundred natural numbers, find the total of
-- the digital sums of the first one hundred decimal digits for
-- all the irrational square roots.
----------------------------------------------------------------------

module Main where

-- See:
-- http://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Decimal_.28base_10.29
-- for a description of this algorithm.

nextP :: Integer -> Integer -> (Integer, Integer)
nextP p c =
   walk 9 where
   walk x = let y = (p20 + x) * x in if y < c then (x, c-y) else walk (x-1)
   p20 = p * 20

iSqrtDigs :: Integer -> Integer -> [Int] -> [Int]
iSqrtDigs _ _ [] = []
iSqrtDigs p c (a:as) =
   let aInt = fromIntegral a in
   let c' = c * 100 + aInt in
   let (x, c2) = nextP p c' in
   fromIntegral x : iSqrtDigs (p * 10 + x) c2 as

deBase100 0 = []
deBase100 n = deBase100 (n `div` 100) ++ [n `mod` 100]

sourceNum :: Int -> [Int]
sourceNum n = take 100 $ deBase100 n ++ repeat 0

sqrtSum :: Int -> Int
sqrtSum = sum . iSqrtDigs 0 0 . sourceNum

isqrt :: Int -> Int
isqrt = floor . sqrt . fromIntegral 

isSquare :: Int -> Bool
isSquare x = let q = isqrt x in q*q == x

euler80 :: Int
euler80 = sum $ map sqrtSum $ filter (not . isSquare) [1 .. 100]

main :: IO ()
main = print euler80
