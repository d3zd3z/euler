#! /usr/bin/env ruby19
#$-w = true
######################################################################
# Starting with 1 and spiralling anticlockwise in the following way, a
# square spiral with side length 7 is formed.
#
# 37 36 35 34 33 32 31
# 38 17 16 15 14 13 30
# 39 18  5  4  3 12 29
# 40 19  6  1  2 11 28
# 41 20  7  8  9 10 27
# 42 21 22 23 24 25 26
# 43 44 45 46 47 48 49
#
# It is interesting to note that the odd squares lie along the bottom
# right diagonal, but what is more interesting is that 8 out of the 13
# numbers lying along both diagonals are prime; that is, a ratio of
# 8/13 ≈ 62%.
#
# If one complete new layer is wrapped around the spiral above, a
# square spiral with side length 9 will be formed. If this process is
# continued, what is the side length of the square spiral for which
# the ratio of primes along both diagonals first falls below 10%?
######################################################################

require 'prime'
require 'rational'
require 'set'

# Return an array of the diagonals of a square with sides 2*n+1.
def diags(n)
  #result = [1]
  result = []
  1.upto(n) do |x|
    sq = (2*x-1)**2
    # Don't compute the squre value, since it is never prime.
    1.upto(3) do |ph|
      result << sq + 2*ph*x
    end
  end
  result
end

# The limit of our search.
LIMIT = 3000
@primes = Set.new
puts "Computing prime numbers up to #{(2*LIMIT)**2}..."
Prime.each((2*LIMIT)**2) { |x| @primes << x }
puts "Done"
# p @primes.to_a.sort[-1]

def ratio(n)
  fail "LIMIT set too low" if n > LIMIT
  d = diags(n)
  pcount = d.count {|x| @primes.include?(x)}
  #pcount = d.count {|x| x.prime?}
  puts "For #{2*n+1} pcount=#{pcount}, d=#{d.length}, d2=#{4*n+1}"
  Rational(pcount, 4*n+1)
end

n = 1
r = nil
stop_limit = Rational(1, 10)
loop do
  r = ratio(n)
  printf "%3d %9.3f\n", (2*n+1), (r.to_f * 100)
  break if r < stop_limit
  n += 1
end
printf "%3d %9.3f\n", (2*n+1), (r.to_f * 100)
