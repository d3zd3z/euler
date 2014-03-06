-- Problem 4
--
-- 16 November 2001
--
--
-- A palindromic number reads the same both ways. The largest palindrome made
-- from the product of two 2-digit numbers is 9009 = 91 × 99.
--
-- Find the largest palindrome made from the product of two 3-digit numbers.
--
-- 906609

function rev_digits(num, base)
  base = base or 10
  local result = 0
  while num > 0 do
    result = result * base + num % base
    num = math.floor(num / base)
  end
  return result
end

function is_palindrome(num, base)
  return num == rev_digits(num, base)
end

function solve ()
  local biggest = 0
  for a = 100, 999 do
    for b = a, 999 do
      local ab = a * b
      if ab > biggest and is_palindrome(ab) then
        biggest = ab
      end
    end
  end
  return biggest
end

print(solve())
