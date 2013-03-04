-- Number utilities.

module Nums (
   digits,
   undigits,
   isqrt,

   module Primes
) where

import Primes
import Data.Bits
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

-- Compute an integer square root using shifting, etc.
isqrt :: (Integral a, Bits a) => a -> a
isqrt input = loop 0 (findBit input 1) input
  where
    findBit num b
      | b <= num  = findBit num (b `shiftL` 2)
      | otherwise = b
    loop result 0 _ = result
    loop result b num =
      let rb = result + b in
      let rlsr1 = result `shiftR` 1 in
      let bitlsr2 = b `shiftR` 2 in
      if num >= rb then
        loop (rlsr1 + b) bitlsr2 (num - rb)
      else
        loop rlsr1 bitlsr2 num
