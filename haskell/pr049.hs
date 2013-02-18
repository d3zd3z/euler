-- The arithmetic sequence, 1487, 4817, 8147, in which each of the
-- terms increases by 3330, is unusual in two ways: (i) each of the
-- three terms are prime, and, (ii) each of the 4-digit numbers are
-- permutations of one another.
--
-- There are no arithmetic sequences made up of three 1-, 2-, or
-- 3-digit primes, exhibiting this property, but there is one other
-- 4-digit increasing sequence.
--
-- What 12-digit number do you form by concatenating the three terms
-- in this sequence?

module Main where

import Data.List
import qualified Data.Set as Set
import Nums (digits, primes, undigits)

main :: IO ()
main = do
   -- The simple answer is useful.
   let nums = solve 1000 10000
   putStrLn $ show nums
   -- And the one wanted by the program will be the last one.
   putStrLn $ intercalate "\n" $ map (concatMap show) nums

-- This is a fairly naive solution, which computes all of the
-- permutations, even with duplicates, and then removes those
-- duplicates.

permsOf :: Int -> [Int]
permsOf = map undigits . permutations . digits

primePerms :: (Int -> Bool) -> Int -> [Int]
primePerms isPrime = filter isPrime . permsOf

valid :: [Int] -> Bool
valid [a,b,c] | a /= b && (b-a) == (c-b) = True
valid _ = False

solve :: Int -> Int -> [[Int]]
solve low high =
   let nums = dropWhile (< low) $ takeWhile (< high) primes in
   let isPrime = (`Set.member` (Set.fromList nums)) in
   nub $ filter valid $ concatMap subsequences $ map (sort . primePerms isPrime) nums
