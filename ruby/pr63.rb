#! /usr/bin/env ruby19
$-w = true
######################################################################
# The 5-digit number, 16807=7^(5), is also a fifth power. Similarly,
# the 9-digit number, 134217728=8^(9), is a ninth power.
#
# How many n-digit positive integers exist which are also an nth
# power?
######################################################################

def count_powers(digits)
  count = 0
  base = 1
  loop do
    pow = base**digits
    len = pow.to_s.length
    break if len > digits
    count += 1 if len == digits
    base += 1
  end
  count
end

# This does appear to stop at the first zero.
offset = 1
total = 0
loop do
  c = count_powers offset
  break if c == 0
  total += c
  offset += 1
end

p total
