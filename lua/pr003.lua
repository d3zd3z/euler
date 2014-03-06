-- Problem 3
--
-- The prime factors of 13195 are 5, 7, 13 and 29.
--
-- What is the largest prime factor of the number 600851475143 ?
--
-- 6857

function solve ()
  local base = 600851475143
  local p = 3
  while base > 1 do
    if base % p == 0 then
      base = base / p
    else
      p = p + 2
    end
  end
  return p
end

print(solve())
