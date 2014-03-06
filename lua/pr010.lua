-- Problem 10
--
-- 08 February 2002
--
--
-- The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
--
-- Find the sum of all the primes below two million.
--
-- 142913828922

local sieve = require('sieve')

function solve ()
  local sv = sieve.Sieve()
  local total = 0
  local p = 2
  while p < 2000000 do
    total = total + p
    p = sv:next_prime(p)
  end
  return total
end

print(solve())
