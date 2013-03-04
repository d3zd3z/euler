----------------------------------------------------------------------
-- The 5-digit number, 16807=75, is also a fifth power. Similarly, the
-- 9-digit number, 134217728=89, is a ninth power.
--
-- How many n-digit positive integers exist which are also an nth
-- power?
--
-- Answer: 49
----------------------------------------------------------------------

module Main where

main :: IO ()
main = putStrLn $ show solve

-- There's some math in the discussion about where this stops being
-- possible, but just stopping after a while does produce the correct
-- answer.
solve :: Int
solve = length $ concatMap numPowers [1..25]

numPowers :: Int -> [Integer]
numPowers n = dropWhile (< 10^(n-1)) $
              takeWhile (< 10^n) $
              [ x^n | x <- [1..] ]
