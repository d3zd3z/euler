----------------------------------------------------------------------
-- The fraction ^(49)/_(98) is a curious fraction, as an inexperienced
-- mathematician in attempting to simplify it may incorrectly believe
-- that ^(49)/_(98) = ^(4)/_(8), which is correct, is obtained by
-- cancelling the 9s.
--
-- We shall consider fractions like, ^(30)/_(50) = ^(3)/_(5), to be
-- trivial examples.
--
-- There are exactly four non-trivial examples of this type of
-- fraction, less than one in value, and containing two digits in the
-- numerator and denominator.
--
-- If the product of these four fractions is given in its lowest
-- common terms, find the value of the denominator.
----------------------------------------------------------------------

module Main where

import Data.Ratio
import Data.Maybe (catMaybes)

main :: IO ()
main = print $ denominator $ product $ catMaybes [ justCurious ab cd |
   ab <- [11 .. 99],
   cd <- [ab+1 .. 99] ]

justCurious :: Int -> Int -> Maybe (Ratio Int)
justCurious ab cd =
   if (d /= 0 && b == c && ab%cd == a%d)
      then Just $ ab%cd
      else Nothing
   where
      a = ab `div` 10
      b = ab `mod` 10
      c = cd `div` 10
      d = cd `mod` 10
