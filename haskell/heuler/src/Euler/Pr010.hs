{- # LANGUAGE FlexibleContexts # -}
----------------------------------------------------------------------
-- The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
--
-- Find the sum of all the primes below two million.

module Euler.Pr010 (pr010) where

import Euler.Problem
-- import qualified Euler.Primes as Primes
import qualified Data.IntSet as S
import Data.IntSet (IntSet)

import qualified Data.Array.Unboxed as UA
import Control.Monad.ST (ST)
import Data.Array.ST (STUArray)
import qualified Data.Array.ST as SA

pr010 :: Problem
pr010 = Problem { prNumber = 10, prOp = return answer, prCorrect = 142913828922 }

-- Needs to be an Integer as Haskell only requires Int to be at least
-- 30 bits.
answer :: Integer
-- answer = sum $ takeWhile (< 2000000) Primes.lazyPrimes
-- answer = sum $ takeWhile (< 2000000) primes
-- answer = fromIntegral $ sum $ S.toList $ makeSieve 2000000
answer = fromIntegral $ sum $ makeSieve2 2000000

-- This simplistic prime sieve seems to be faster than the multiple
-- wheel solution in Euler.Primes.
primes :: [Integer]
primes = 2 : 3 : [x | x <- [5..], isPrime x]

isPrime :: Integer -> Bool
isPrime n = filter (\x -> n `mod` x == 0) factors == []
   where
      factors = takeWhile (<= (floor (sqrt $ fromIntegral n :: Double))) primes

-- If we know a prime limit, we can compute a regular sieve from it.
-- The result of this is an IntSet of all the composites.  This can't
-- really work on a 32-bit machine as the result would be too large.
-- Turns out this is still somewhat slower than the simple sieve
-- above.  We can probably only do better by using an STArray and
-- working up an imperative solution.
makeSieve :: Int -> IntSet
makeSieve limit = run S.empty $ S.fromList [2 .. limit-1]
   where
      run r work
         | S.null work = r
         | otherwise =
            let p = S.findMin work in
            run (S.insert p r) (S.difference work $ S.fromList $ comps p)
      comps p = [p, p+p, limit-1]

-- Implement an imperative sieve in haskell using STUArray
-- stSieve :: (forall s. ST s (Int -> STUArray s Int Bool))

type BitArray s = STUArray s Int Bool

-- Generate primes via sieve based on the ST sieve.  This is somewhat
-- faster than the other solutions (about 4x).
makeSieve2 :: Int -> [Int]
makeSieve2 limit =
   let ary = SA.runSTUArray $ makeBitSieve limit in
   map fst $ filter snd $ UA.assocs ary

makeBitSieve :: Int -> ST s (BitArray s)
makeBitSieve limit = do
   ary <- baseArray limit
   elimComposite ary 2
   elimComposite ary 3
   walk ary 3
   return ary

-- Begin crossing off composites, following the given prime candidate
-- (which should be odd).
walk :: BitArray s -> Int -> ST s ()
walk ary pp = do
   p <- nextPrime ary pp
   case p of
      Nothing -> return ()
      Just p -> do
         elimComposite ary p
         walk ary (p + 2)

-- The base sieve, all the numbers from 2 to the limit.  They are True
-- for primes.
baseArray :: Int -> ST s (BitArray s)
baseArray limit = SA.newArray (2, limit) True

-- Eliminate all multiples of the prime p
elimComposite :: BitArray s -> Int -> ST s ()
elimComposite ary p = do
   (_, limit) <- SA.getBounds ary
   mapM_ (\k -> SA.writeArray ary k False) [p + p, p + p + p .. limit]

-- Find the next prime from the sieve, starting with p.  P should be
-- at least 3.
nextPrime :: BitArray s -> Int -> ST s (Maybe Int)
nextPrime ary p = do
   b <- SA.getBounds ary
   if SA.inRange b p then do
      isPrime <- SA.readArray ary p
      if isPrime
         then return $ Just p
         else nextPrime ary (p + 2)
   else return Nothing
