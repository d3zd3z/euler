-- Problem 14
--
-- 05 April 2002
--
--
-- The following iterative sequence is defined for the set of positive
-- integers:
--
-- n → n/2 (n is even)
-- n → 3n + 1 (n is odd)
--
-- Using the rule above and starting with 13, we generate the following
-- sequence:
--
-- 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
--
-- It can be seen that this sequence (starting at 13 and finishing at 1)
-- contains 10 terms. Although it has not been proved yet (Collatz Problem),
-- it is thought that all starting numbers finish at 1.
--
-- Which starting number, under one million, produces the longest chain?
--
-- NOTE: Once the chain starts the terms are allowed to go above one million.

function simple_length(n)
  if n == 1 then
    return 1
  elseif n % 2 == 0 then
    return 1 + simple_length(n / 2)
  else
    return 1 + simple_length(3 * n + 1)
  end
end

function make_cached(limit)
  local cache = {}

  local chain2
  local function len(n)
    if n < limit then
      local cc = cache[n]
      if cc then
        return cc
      end
      cc = chain2(n)
      cache[n] = cc
      return cc
    else
      return chain2(n)
    end
  end
  chain2 = function(n)
    if n == 1 then
      return 1
    elseif n % 2 == 0 then
      return 1 + len(n / 2)
    else
      return 1 + len(3 * n + 1)
    end
  end
  return len
end

function compute_len(lenfun)
  local max_len = 0
  local max = 0
  for x = 1, 999999 do
    local len = lenfun(x)
    if len > max_len then
      max_len = len
      max = x
    end
  end
  return max
end

function solve ()
  -- return compute_len(simple_length)
  return compute_len(make_cached(10240))
end

print(solve())
