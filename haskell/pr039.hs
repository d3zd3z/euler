----------------------------------------------------------------------
-- If p is the perimeter of a right angle triangle with integral
-- length sides, {a,b,c}, there are exactly three solutions for p =
-- 120.
--
-- {20,48,52}, {24,45,51}, {30,40,50}
--
-- For which value of p ≤ 1000, is the number of solutions maximised?
----------------------------------------------------------------------

module Main where

main :: IO ()
main = print $ maximum $ zip (map (length . solutions) [1..1000]) [1..]

solutions :: Int -> [(Int, Int, Int)]

-- Brute force, not very good.  Takes over a minute.
solutions' p = [ (a,b,c) |
   a <- [1..p],
   b <- [a+1 .. p],
   let c = isqrt (a*a + b*b),
   a + b + c == p,
   a*a + b*b == c*c ]

-- Solution using better math.  b=(p^2-2pa)/(2(p-a))
solutions p = [ (a,b,c) |
   a <- [1..p],
   let num = p^2 - 2*p*a,
   let denom = 2*(p-a),
   denom > 0,
   num `mod` denom == 0,
   let b = num `div` denom,
   b > a,  -- Unique solutions
   let c = isqrt (a*a + b*b) ]

isqrt :: Int -> Int
isqrt = floor . sqrt . fromIntegral
