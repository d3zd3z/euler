----------------------------------------------------------------------
-- Problem 76
--
-- 13 August 2004
--
-- It is possible to write five as a sum in exactly six different ways:
--
-- 4 + 1
-- 3 + 2
-- 3 + 1 + 1
-- 2 + 2 + 1
-- 2 + 1 + 1 + 1
-- 1 + 1 + 1 + 1 + 1
--
-- How many different ways can one hundred be written as a sum of at least two
-- positive integers?
----------------------------------------------------------------------
-- 190569291

module Main where

import Control.Monad (forM)
import Control.Monad.Trans.State
import qualified Data.Map as Map
import Data.Map (Map)

-- First, make sure we understand the problem, and just implement a
-- naive solution.
-- Two things here.  One is that a sum can't include a single number.
-- However, there is only one of these, so we can just subtract one
-- from the result.
-- Second is that for any given point, we want to know how much ways
-- of adding up to 'n' there are.

-- The first case is special, since it is the only one that requires
-- two numbers.
{-
ways :: Int -> Int
ways n =
   sum [ ways1 (n - i) i |
      i <- [1 .. n-1] ]
-}

-- Compute the number of ways of adding up the numbers up to 'k' to
-- 'k'.
{-
ways :: Int -> Int -> Int
ways n _ | n < 0 = error "Negative sum"
ways n k | n < k = error "Max digit larger than sum"
ways 0 _ = 1
ways n k =
   sum [ ways newN (min newN i) |
      i <- [1 .. min k n],
      let newN = n - i ]
-}

type Cached a = State (Map (Int, Int) Int) a

-- More complicated version using a map to memoize the result.
ways :: Int -> Int -> Cached Int
ways n k = do
   x <- gets $ Map.lookup (n, k)
   case x of
      Nothing -> do
         result <- ways' n k
         modify $ Map.insert (n, k) result
         return $ result
      Just result -> return result

ways' :: Int -> Int -> Cached Int
ways' 0 _ = return 1
ways' n k = do
   items <- forM [1 .. min n k] $ \i -> do
      let newN = n - i
      ways newN (min newN i)
   return $ sum items

solve :: Int
solve = (evalState (ways 100 100) Map.empty) - 1

main :: IO ()
main = print solve
