-- Problem 7
--
-- 28 December 2001
--
--
-- By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
-- that the 6th prime is 13.
--
-- What is the 10 001st prime number?
--
-- 104743

local sieve = require('sieve')

function solve ()
  local sv = sieve.Sieve()
  local prime = 2
  local count = 1
  while count < 10001 do
    prime = sv:next_prime(prime)
    count = count + 1
  end
  return prime
end

print(solve())
