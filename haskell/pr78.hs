----------------------------------------------------------------------
-- Problem 78
--
-- 10 September 2004
--
-- Let p(n) represent the number of different ways in which n coins can be
-- separated into piles. For example, five coins can separated into piles in
-- exactly seven different ways, so p(5)=7.
--
-- OOOOO
--
-- OOOO   O
--
-- OOO   OO
--
-- OOO   O   O
--
-- OO   OO   O
--
-- OO   O   O   O
--
-- O   O   O   O   O
--
-- Find the least value of n for which p(n) is divisible by one million.
----------------------------------------------------------------------
-- 55374

module Main where

-- Similar to problem 76 (but a single partition is allowed).

import Control.Monad
import Control.Monad.Trans.State
import Data.List
import qualified Data.Map as Map
import Data.Map (Map)

type Cached a = State (Map (Int, Int) Int) a

-- This works, but is rather slow.
-- TODO: Investigate ways of enumerating the partition counts.

-- Since the answer asks for divisible by one million, the ways count
-- is mod 1million.
modPlus :: Int -> Int -> Int
modPlus x y =
   let s = x + y in
   if s > 1000000 then s - 1000000 else s

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
   return $! foldl' modPlus 0 items

-- solveS :: Cached Int
solveS = do
   counts <- forM [1 .. ] $ \i -> do
      c <- ways i i
      return $ (i, c)
   case find (\ (_, x) -> (x `mod` 1000000) == 0) counts of
      Just x -> return x
      Nothing -> error "No answer"

solve1 = evalState solveS Map.empty

fact :: Int -> Integer
fact n = product [1 .. fromIntegral n]

-- choose
choose :: Int -> Int -> Integer
choose n k =
   fact n `div` fact (n-k) `div` fact k

-- The bell numbers.
bells :: [Integer]
bells = 1 : map bell [1..] where
   bell n =
      let bk = take n bells in
      let x = [ choose (n-1) k | k <- [0..] ] in
      sum $ zipWith (*) bk x

solve2 :: Int
solve2 = length $ takeWhile (\x -> x `mod` 1000000 /= 0) bells

main :: IO ()
main = print solve2
