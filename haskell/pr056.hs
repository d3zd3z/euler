----------------------------------------------------------------------
-- A googol (10^(100)) is a massive number: one followed by
-- one-hundred zeros; 100^(100) is almost unimaginably large: one
-- followed by two-hundred zeros. Despite their size, the sum of the
-- digits in each number is only 1.
--
-- Considering natural numbers of the form, a^(b), where a, b < 100,
-- what is the maximum digital sum?
----------------------------------------------------------------------

module Main where

main :: IO ()
main = print $ maximum [ dsum (a^b) | a <- [1..100], b <- [1..100] ]

dsum :: Integer -> Int
dsum 0 = 0
dsum n = fromIntegral (n `mod` 10) + dsum (n `div` 10)
