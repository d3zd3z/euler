----------------------------------------------------------------------
-- The primes 3, 7, 109, and 673, are quite remarkable. By taking any
-- two primes and concatenating them in any order the result will
-- always be prime. For example, taking 7 and 109, both 7109 and 1097
-- are prime. The sum of these four primes, 792, represents the lowest
-- sum for a set of four primes with this property.
--
-- Find the lowest sum for a set of five primes for which any two
-- primes concatenate to produce another prime.
----------------------------------------------------------------------
-- 26033

module Main where

import Control.Arrow (first)
import Data.IntSet (IntSet)
import qualified Data.IntSet as IntSet
import Data.IntMap (IntMap)
import qualified Data.IntMap as IntMap
import Data.List
import Nums

tenFactor :: Int -> Int
tenFactor 0 = 1
tenFactor n = 10 * tenFactor (n `div` 10)

concatNum :: Int -> Int -> Int
concatNum a b = a * tenFactor b + b

valid :: [Int] -> Bool
valid =
   all isPrime .
      concatMap catpairs .
      subsequences
   where
      catpairs [a,b] =
         [concatNum a b, concatNum b a]
      catpairs _ = []

-- The Data.List.subsequences returns the subsequences in a useful
-- order, but also returns a large number that we don't need.  This is
-- equivalent to
--   filter (\x -> length x = len) . subsequences
-- but without generating all of the other subsequences.

isLenN :: Int -> [a] -> Bool
isLenN 0 [] = True
isLenN 0 _ = False
isLenN n (_:xs) = isLenN (n-1) xs
isLenN _ [] = False

{-
 - This solution is very slow.
solve :: Int -> [Int]
solve len =
   head $ filter valid $
      filter (\x -> length x == len) $
      subsequences primes

main :: IO ()
main = do
   let answer = solve 4
   print answer
   print $ sum answer
-}

-- For each prime, it's element in the set consists of 
pairs :: Int -> IntMap IntSet
pairs limit =
   IntMap.fromListWith IntSet.union [ elt | 
      x <- takeWhile (< limit) primes,
      y <- takeWhile (< limit) primes,
      x /= y,
      isPrime $ concatNum x y,
      isPrime $ concatNum y x,
      elt <- [ (x, IntSet.singleton y), (y, IntSet.singleton x) ] ]

-- Solve :: IntMap IntSet -> Int -> [
expand :: IntMap IntSet -> [([Int], IntSet)] -> [([Int], IntSet)]
expand mapping apairs =
   [ ((onum:nums), combined) |
      (nums, numsSet) <- apairs,
      onum <- IntSet.toList numsSet,
      let onumSet = IntMap.findWithDefault IntSet.empty onum mapping,
      let combined = IntSet.intersection numsSet onumSet,
      not $ IntSet.null combined ]

extract :: ([Int], IntSet) -> [Int]
extract (nums, other) = IntSet.toList other ++ nums

solve :: Int -> [[Int]]
solve limit =
   let p = pairs limit in
   let initP = map (Control.Arrow.first (:[])) $ IntMap.toList p in
   let expanded = expand p $ expand p $ expand p $ initP in
   map extract $ filter (\ (_, s) -> IntSet.size s == 1) expanded

main :: IO ()
main = print $ minimum $ map sum $ solve 10000
