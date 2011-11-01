-- Number utilities.

module Nums (
   digits,
   undigits,

   module Primes
) where

import Primes
import Data.List

digits :: Integral a => a -> [Int]
digits 0 = [0]
digits a | a < 0 = error "Only positive numbers are supported by digits"
digits a = digitsS a []

digitsS :: Integral a => a -> ([Int] -> [Int])
digitsS 0 = id
digitsS a =
   let (n, m) = divMod a 10 in
   digitsS n . (fromIntegral m:)

undigits :: [Int] -> Int
undigits = foldl' (\a b -> a * 10 + b) 0

