-- A prime number sieve.

local sieve = {}

local default_size = 8192

sieve.Sieve = {}
sieve.Sieve.__index = sieve.Sieve

setmetatable(sieve.Sieve, {
  __call = function(cls, ...)
    return cls.new(...)
  end})

function sieve.Sieve:fill(size)
  local v = {}
  v[0] = true
  v[1] = true

  local pos = 2
  while pos <= size do
    if v[pos] then
      pos = pos + 2
    else
      local n = pos + pos
      while n <= size do
        v[n] = true
        n = n + pos
      end
      if pos == 2 then
        pos = 3
      else
        pos = pos + 2
      end
    end
  end

  self.composites = v
  self.limit = size
end

function sieve.Sieve.new()
  local self = setmetatable({}, sieve.Sieve)
  self:fill(default_size)
  return self
end

function sieve.Sieve:is_prime(n)
  if n >= self.limit then
    local nlimit = self.limit
    while nlimit < n do
      nlimit = nlimit * 8
    end
    self:fill(nlimit)
  end
  return not self.composites[n]
end

function sieve.Sieve:next_prime(n)
  if n == 2 then
    return 3
  else
    local result = n + 2
    while not self:is_prime(result) do
      result = result + 2
    end
    return result
  end
end

-- do
--   local sv = sieve.Sieve()
--   p = 2
--   while p < 100 do
--     print(p)
--     p = sv:next_prime(p)
--   end
-- end

return sieve
