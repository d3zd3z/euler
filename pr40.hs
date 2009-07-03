----------------------------------------------------------------------
-- An irrational decimal fraction is created by concatenating the
-- positive integers:
--
-- 0.123456789101112131415161718192021...
--
-- It can be seen that the 12^(th) digit of the fractional part is 1.
--
-- If d_(n) represents the n^(th) digit of the fractional part, find
-- the value of the following expression.
--
-- d_(1) × d_(10) × d_(100) × d_(1000) × d_(10000) × d_(100000) ×
-- d_(1000000)
----------------------------------------------------------------------

module Main where

main :: IO ()
main = print $ product $ map (ifrac !!) [0, 9, 99, 999, 9999, 99999, 999999]

ifrac :: [Int]
ifrac = foldr (++) [] (map digits [1..])

digits :: Int -> [Int]
digits = reverse . digits'
   where
      digits' 0 = []
      digits' n = (n `mod` 10) : digits' (n `div` 10)
