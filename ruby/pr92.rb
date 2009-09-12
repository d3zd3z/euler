#! /usr/bin/env ruby19
$-w = true
######################################################################
# A number chain is created by continuously adding the square of the
# digits in a number to form a new number until it has been seen
# before.
#
# For example,
#
# 44 → 32 → 13 → 10 → 1 → 1
# 85 → 89 → 145 → 42 → 20 → 4 → 16 → 37 → 58 → 89
#
# Therefore any chain that arrives at 1 or 89 will become stuck in an
# endless loop. What is most amazing is that EVERY starting number
# will eventually arrive at 1 or 89.
#
# How many starting numbers below ten million will arrive at 89?
######################################################################

# To make this faster, remember all answer below 600, rather than
# computing them multiple times.

@solutions = Array.new(600)

def shrink(n)
  # n.to_s.chars.to_a.map {|x| x.to_i**2 }.reduce(:+)
  ans = 0
  while n > 0 do
    tmp = n % 10
    n = n / 10
    ans += tmp * tmp
  end
  ans
end

# Resolve a given number to the 89 or 1 sequence.
def brute_resolve(num)
  while num != 1 && num != 89 do
    num = shrink num
  end
  num
end

def resolve(num)
  if num >= 600
    resolve(shrink(num))
  else
    @solutions[num] = brute_resolve(num) unless @solutions[num]
    @solutions[num]
  end
end

count = 0
1.upto(10_000_000) do |x|
  count += 1 if resolve(x) == 89
  # puts x if (x % 100000) == 0
end
puts count
