----------------------------------------------------------------------
-- It is possible to show that the square root of two can be expressed
-- as an infinite continued fraction.
--
-- √ 2 = 1 + 1/(2 + 1/(2 + 1/(2 + ... ))) = 1.414213...
--
-- By expanding this for the first four iterations, we get:
--
-- 1 + 1/2 = 3/2 = 1.5
-- 1 + 1/(2 + 1/2) = 7/5 = 1.4
-- 1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 1.41666...
-- 1 + 1/(2 + 1/(2 + 1/(2 + 1/2))) = 41/29 = 1.41379...
--
-- The next three expansions are 99/70, 239/169, and 577/408, but the
-- eighth expansion, 1393/985, is the first example where the number
-- of digits in the numerator exceeds the number of digits in the
-- denominator.
--
-- In the first one-thousand expansions, how many fractions contain a
-- numerator with more digits than denominator?
----------------------------------------------------------------------

module Main where

import Data.List
import Data.Ratio

sqrt2 :: Int -> Ratio Integer
sqrt2 n = 1 + 1 / (sqrt2' n)

sqrt2' :: Int -> Ratio Integer
sqrt2' 0 = 2
sqrt2' n = 2 + 1 / (sqrt2' (n-1))

qualified :: Ratio Integer -> Bool
qualified x =
   let n = numerator x in
   let m = denominator x in
   length (show n) > length (show m)

-- This is dreadful, just using Integers and no work.
-- A good exercise would be to figure out how to do this with just
-- Int.
main2 :: IO ()
main2 = putStrLn $ show $ length $ filter qualified $ map sqrt2 [0..999]

-- From glguy in the forum (adding type signatures).
twoex :: [(Integer, Integer)]
twoex = zip ns ds where
   ns = 3 : zipWith (\x y -> x + 2 * y) ns ds
   ds = 2 : zipWith (+) ns ds

len :: Show a => a -> Int
len = length . show

main :: IO ()
main = print $ length $ filter (\(n,d) -> len n > len d) $ take 1000 twoex
