----------------------------------------------------------------------
-- Various utilities associated with prime numbers.

module Primes where

import Data.List (group, foldl')
import Data.IntMap (IntMap)
import qualified Data.IntMap as IntMap
import Data.Map (Map)
import qualified Data.Map as Map

-- Not necessarily in order.
divisors :: Int -> [Int]
divisors = spread . primeFactors

spread :: [(Int, Int)] -> [Int]
spread [] = [1]
spread ((p,count):r) = 
   [ res * p^x |
      res <- spread r,
      x <- [0..count] ]

primeFactors :: Int -> [(Int, Int)]
primeFactors n = map (\x -> (head x, length x)) (group answer)
   where
      answer = seek n primes
      seek 1 _ = []
      seek x fs@(f:fr)
         | x `mod` f == 0   = f : seek (x `div` f) fs
         | f > x            = error "Factoring coding error"
         | otherwise        = seek x fr

primes :: [Int]
primes = 2 : 3 : [x | x <- [5,7..], isPrime x]

isPrime :: Int -> Bool
isPrime n = n > 1 && filter (\x -> n `mod` x == 0) factors == []
   where
      factors = takeWhile (<= (floor $ sqrt $ fromIntegral n)) primes

-- Horrible solution, but interesting in it's simplicity.
primes2 :: [Int]
primes2 = sieve [2..]
   where
      sieve (p:x) = p : sieve [ n | n <- x, n `mod` p > 0 ]

-- This is slightly better, but doesn't have an easy isPrime
-- associated with it (at least that isn't linear).
-- Test the alternate prime.
type PQ = IntMap [Int]

fprimes :: [Int]
fprimes = 2 : 3 : (primes' 5 $ IntMap.singleton 9 [6])

primes' :: Int -> PQ -> [Int]
primes' n pq = case IntMap.minViewWithKey pq of
   Just ((x, _), _) | n < x ->
      let newPq = IntMap.insertWith (++) (n*n) [n+n] pq in
      n : primes' (n + 2) newPq
   Just ((x, step), pq') ->
      let update st = IntMap.insertWith (++) (x + st) [st] in
      let newPq = foldr update pq' step in
      primes' (n + 2) newPq
   Nothing -> error "Ran out of integers"

-- As above, but for general number.
type M a = Map a [a]

lazyPrimes :: (Num a, Ord a) => [a]
lazyPrimes = 2 : 3 : (iprimes' 5 $ Map.singleton 9 [6])

iprimes' :: (Num a, Ord a) => a -> M a -> [a]
iprimes' n pq = case Map.minViewWithKey pq of
  Just ((x, _), _) | n < x ->
    let newPq = Map.insertWith (++) (n*n) [n+n] pq in
    n : iprimes' (n+2) newPq
  Just ((x, step), pq') ->
    let update st = Map.insertWith (++) (x+st) [st] in
    let newPq = foldr update pq' step in
    iprimes' (n+2) newPq
  Nothing -> error "ran out of integers"

----------------------------------------------------------------------
-- A Lazy prime sieve, based on integers, mostly because the sieve
-- needs n^2 stored as intermediate value.
-- Ugh, all of this, is just a crappy implementation of the 'fprimes' above.

type NextMap = Map Integer Node
data Node = Node { nodeNext :: Integer, nodeSteps :: [Integer] }
          deriving Show
data Sieve = Sieve { sievePrime :: Integer, sieveNexts :: NextMap }
           deriving Show

initial :: Sieve
initial = Sieve { sievePrime = 2, sieveNexts = Map.empty }

-- Return the next prime number, and a new sieve redy to generate more.
next :: Sieve -> (Integer, Sieve)
next (Sieve { sievePrime=2 }) = (2, Sieve { sievePrime = 3, sieveNexts = Map.empty })
next (Sieve { sievePrime=3 }) =
  let nexts = addNode Map.empty (3*3) (3+3) in
  (3, Sieve { sievePrime = 5, sieveNexts = nexts })
next (Sieve { sievePrime = cur, sieveNexts = nexts }) =
  let bump = cur + 2 in
  let (peekNext, peek) = Map.findMin nexts in
  if cur < peekNext then
    (cur, Sieve { sievePrime = bump,
                  sieveNexts = addNode nexts (cur*cur) (cur+cur) })
  else
    next (Sieve { sievePrime = bump,
                  sieveNexts = updateFirst nexts peek })

-- Given 'nexts' return a new nexts map containing the given 'next'
-- and 'step' value.  If the 'next' is not present, it will be added,
-- otherwise, the step will be added to the found node.
addNode :: NextMap -> Integer -> Integer -> NextMap
addNode nexts next step =
  case Map.lookup next nexts of
    Just node -> Map.insert next (node { nodeSteps = step : nodeSteps node }) nexts
    Nothing -> Map.insert next (Node { nodeNext = next, nodeSteps = [step] }) nexts

-- Take the given 'next' node, remove it from the map, and advance
-- it's divisor values.
updateFirst :: NextMap -> Node -> NextMap
updateFirst nexts node =
  foldl' update base (nodeSteps node)
  where base = Map.delete next nexts
        update :: NextMap -> Integer -> NextMap
        update map step = addNode map (next + step) step
        next = nodeNext node
