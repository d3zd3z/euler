-- Problem 5
--
-- 30 November 2001
--
--
-- 2520 is the smallest number that can be divided by each of the numbers
-- from 1 to 10 without any remainder.
--
-- What is the smallest positive number that is evenly divisible by all of
-- the numbers from 1 to 20?
--
-- 232792560

function gcd(a, b)
  local r = a % b
  while r > 0 do
    a = b
    b = r
    r = a % b
  end
  return b
end

function lcm(a, b)
  return (a / gcd(a, b)) * b
end

function solve ()
  local reduct = 1
  for i = 2, 20 do
    reduct = lcm(reduct, i)
  end
  return reduct
end

print(solve())
