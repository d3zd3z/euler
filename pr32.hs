----------------------------------------------------------------------
-- We shall say that an n-digit number is pandigital if it makes use
-- of all the digits 1 to n exactly once; for example, the 5-digit
-- number, 15234, is 1 through 5 pandigital.
--
-- The product 7254 is unusual, as the identity, 39 × 186 = 7254,
-- containing multiplicand, multiplier, and product is 1 through 9
-- pandigital.
--
-- Find the sum of all products whose multiplicand/multiplier/product
-- identity can be written as a 1 through 9 pandigital.
-- HINT: Some products can be obtained in more than one way so be sure
-- to only include it once in your sum.
----------------------------------------------------------------------

module Main where

import Data.List (nub, permutations)
import Data.Maybe (catMaybes)

-- This is actually fairly wasteful, since it tests all permutations.
-- Really, we only need the initial choosings of 5 digits, and a check
-- if the rest is correct.  But, that's a lot more code, and this only
-- takes a few miliseconds.

main :: IO ()
main = print $ sum $ nub $ catMaybes $ map justPan $ permutations [1,2,3,4,5,6,7,8,9]

-- If the value is pandigital, return 'Just product', otherwise return
-- Nothing.  The only possible ways of getting a proper sum is
-- nn*nnn=nnnn or n*nnnn=nnnn.
justPan :: [Int] -> Maybe Int
justPan [a,b,c,d,e,f,g,h,i] =
   if ((10*a+b) * (100*c+10*d+e) == product ||
       a * (1000*b+100*c+10*d+e) == product)
      then Just product
      else Nothing
   where product = f*1000 + g*100 + h*10 + i
