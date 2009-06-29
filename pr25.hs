----------------------------------------------------------------------
-- What is the first term in the Fibonacci sequence to contain 1000
-- digits?
----------------------------------------------------------------------

module Main where

main :: IO ()
main = print $ (length $ takeWhile (< 10^999) fibs) + 1

fibs :: [Integer]
fibs = fib' 1 1
   where
      fib' a b = a : fib' b (a+b)

-- Alternative way of writing fibs.  Doesn't make any difference,
-- since the large number computation overwhelmes the loop overhead.

fibs2 :: [Integer]
fibs2 = 1 : 1 : fib' fibs2
   where
      fib' (x : y : rs) = x + y : fib' (y : rs)
