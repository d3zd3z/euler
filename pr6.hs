----------------------------------------------------------------------
-- Find the difference between the sum of the squares of the first one
-- hundred natural numbers and the square of the sum.

answer :: Int
answer = a - b
   where
      a = (sum [1..100]) ^ 2
      b = sum (map (^ 2) [1..100])
