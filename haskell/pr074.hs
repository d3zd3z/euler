----------------------------------------------------------------------
-- The number 145 is well known for the property that the sum of the
-- factorial of its digits is equal to 145:
--
-- 1! + 4! + 5! = 1 + 24 + 120 = 145
--
-- Perhaps less well known is 169, in that it produces the longest chain
-- of numbers that link back to 169; it turns out that there are only
-- three such loops that exist:
--
-- 169 → 363601 → 1454 → 169
-- 871 → 45361 → 871
-- 872 → 45362 → 872
--
-- It is not difficult to prove that EVERY starting number will eventually
-- get stuck in a loop. For example,
--
-- 69 → 363600 → 1454 → 169 → 363601 (→ 1454)
-- 78 → 45360 → 871 → 45361 (→ 871)
-- 540 → 145 (→ 145)
--
-- Starting with 69 produces a chain of five non-repeating terms, but the
-- longest non-repeating chain with a starting number below one million is
-- sixty terms.
--
-- How many chains, with a starting number below one million, contain
-- exactly sixty non-repeating terms?
----------------------------------------------------------------------
-- 402

module Main where

import Control.Applicative ((<$>))
import Data.List
import Nums
import qualified Data.Array as A

import qualified Data.IntMap as IntMap
import Data.IntMap (IntMap)
-- import Control.Monad.State
import Control.Monad.Trans.State

-- Memoized fact.
fact :: Int -> Int
fact = memFact where
   ary = A.listArray (0, 9) $ map product $ inits [1..9]
   memFact = (ary A.!)

sumFact :: Int -> Int
sumFact = sum . map fact . digits

factChain :: Int -> [Int]
factChain n = n : factChain (sumFact n)

-- WRONG: This only detects a chain at the beginning.  We need to be a
-- lot more clever.  Perhaps Brent's algorithm is best.
-- Although it Brent's algorithm is nifty, let's start by just looking
-- for a cain length of 60, which is simpler:
{-
isChain :: Int -> [Int] -> Bool
isChain len ns =
   let h = head ns in
   let h2 = head $ drop len ns in
   let middle = drop 1 $ take (len-1) ns in
   h == h2 && not (elem h middle)
-}

-- Brent's length algorithm to detect cycle length.
-- Python version from wikipedia, first half.
-- def brent(f, x0):
--   # main phase: search successive powers of two
--   power = lam = 1
--   tortoise = x0
--   hare = f(x0) # f(x0) is the element/node next to x0.
--   while tortoise != hare:
--       if power == lam:   # time to start a new power of two?
--           tortoise = hare
--           power *= 2
--           lam = 0
--       hare = f(hare)
--       lam += 1
chainLen :: Eq a => [a] -> (Int, Int)
chainLen items = (len, mu) where
   walk power lam tortise hare
      | headEq tortise hare = lam
      | power == lam =
         walk (power*2) 1 hare (tail hare)
      | otherwise =
         walk power (lam+1) tortise (tail hare)

   len = walk 1 1 items (tail items)
   mu = getMu 0 items (drop len items)
   getMu mu tortise hare
      | headEq tortise hare = mu
      | otherwise = getMu (mu+1) (tail tortise) (tail hare)

   headEq (a:_) (b:_) = a == b
   headEq _ _ = error "List ending"

fullChainLen :: Eq a => [a] -> Int
fullChainLen items = case chainLen items of
   (len, mu) -> len + mu

-- This works, but is rather slow.
-- TODO: Memoize certainly small results.
solve :: Int
solve = length $ filter (\l -> fullChainLen l == 60) $ map factChain [1 .. 999999]

----------------------------------------------------------------------
-- As another approach, track a mapping of a small number of nodes
-- using a state monad.

data Status = Searching | Known Int
type SolveState a = State (IntMap Status) a

memoLimit :: Int
memoLimit = 10

memoSolve :: Int
memoSolve =
   length $ filter (== 60) $ evalState (mapM scan [1 .. 999999]) IntMap.empty

scan :: Int -> SolveState Int
scan num = do
   result <- scan' num
   modify $ IntMap.filterWithKey (\k _ -> k < memoLimit)
   return $! result

scan' :: Int -> SolveState Int
-- Note: Can't limit like this, or we get the wrong answer.
-- To actually limit it, we could filter out any numbers larger than
-- our limit when we are done.
-- scan num | num > memoLimit = do
--    next <- scan (sumFact num)
--    return $! 1 + next
scan' num = do
   s <- get
   case IntMap.lookup num s of
      Just (Known x) -> return x
      Just Searching -> do
         modify $ IntMap.insert num (Known 1)
         return 0
      Nothing -> do
         modify $ IntMap.insert num Searching
         next <- (1+) <$> scan (sumFact num)
         modify $ IntMap.insert num (Known next)
         return $! next

main :: IO ()
main = print memoSolve
