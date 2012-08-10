----------------------------------------------------------------------
-- By replacing the 1st digit of *3, it turns out that six of the nine
-- possible values: 13, 23, 43, 53, 73, and 83, are all prime.
--
-- By replacing the 3rd and 4th digits of 56**3 with the same digit,
-- this 5-digit number is the first example having seven primes among
-- the ten generated numbers, yielding the family: 56003, 56113,
-- 56333, 56443, 56663, 56773, and 56993. Consequently 56003, being
-- the first member of this family, is the smallest prime with this
-- property.
--
-- Find the smallest prime which, by replacing part of the number (not
-- necessarily adjacent digits) with the same digit, is part of an
-- eight prime value family.
----------------------------------------------------------------------

module Main where

import Nums
import qualified Data.IntSet as IntSet
import Data.IntSet (IntSet)

main :: IO ()
main = putStrLn $ show $ case solve 1000000 of
   ((answer, _):_) -> answer
   _ -> error "Limit too low"

-- Return which of 0, 1, or 2 are present.  We really only care about
-- odd-repeats > 1, since the even ones won't have enough primes.
repeatsOf :: Int -> [Int]
repeatsOf base =
   let d = digits base in
   [ n |
      n <- [0 .. 2],
      length (filter (== n) d) > 0 ]

subst :: Int -> Int -> Int -> Int
subst from to =
   undigits . map (\x -> if x == from then to else x) . digits

solve limit =
   let myPrimes = takeWhile (< limit) primes in
   let pset = IntSet.fromList $ myPrimes in
   let vals = [ (p, others) |
         p <- myPrimes,
         from <- repeatsOf p,
         let others = [ subst from to p |
               to <- [ from .. 9 ],
               let newNum = subst from to p,
               IntSet.member newNum pset ],
         length others >= 8 ] in
   vals
