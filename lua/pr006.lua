-- Problem 6
--
-- 14 December 2001
--
--
-- The sum of the squares of the first ten natural numbers is,
--
-- 1^2 + 2^2 + ... + 10^2 = 385
--
-- The square of the sum of the first ten natural numbers is,
--
-- (1 + 2 + ... + 10)^2 = 55^2 = 3025
--
-- Hence the difference between the sum of the squares of the first ten
-- natural numbers and the square of the sum is 3025 − 385 = 2640.
--
-- Find the difference between the sum of the squares of the first one
-- hundred natural numbers and the square of the sum.
--
-- 25164150

function solve ()
  local sumsq = 0
  local sqsum = 0
  for i = 1, 100 do
    sumsq = sumsq + i * i
    sqsum = sqsum + i
  end
  sqsum = sqsum * sqsum
  return sqsum - sumsq
end

print(solve())
