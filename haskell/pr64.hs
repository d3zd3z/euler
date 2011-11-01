-- Problem 64.
-- Find length of continued fraction cycle for various sqrts.

module Main where

{-
 -- Don't use this until 'isqrt 15' can be made to converge.
isqrt :: Int -> Int
isqrt n = scan n where
   scan x =
      let x2 = (x + n `div` x) `div` 2 in
      if x == x2 then x
         else scan x2
-}
isqrt :: Int -> Int
isqrt = floor . sqrt . fromIntegral

-- Generate the continued series for a square root.  Simple square
-- roots always repeat starting from the first fractional value, which
-- makes things a bit easier.
sqrtSeries :: Int -> [Int]
sqrtSeries s =
   a0 : steps m1 d1 a1
   where
      a0 = isqrt s
      first@(m1, d1, a1) = step 0 1 a0
      step m d a =
         let m' = d*a - m in
         let d' = (s - (m' ^ 2)) `div` d in
         let a' = (a0 + m') `div` d' in
         (m', d', a')

      steps _ 0 _ = []
      steps m d a =
         let this@(m', d', a') = step m d a in
         if this == first then [a]
            else a : steps m' d' a'

sqrtLen :: Int -> Int
sqrtLen = length . drop 1 . sqrtSeries

solve :: Int
solve = length $ filter odd $ map sqrtLen [1 .. 10000]

main :: IO ()
main = print solve
