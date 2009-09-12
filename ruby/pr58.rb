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
# Returns the set of diagonals (outer 3) of a square with sides 2*n+1.
def diags(n)
  #result = [1]
  result = []
  sq = (2*n-1)**2
  # Don't compute the squre value, since it is never prime.
  1.upto(3) do |ph|
    result << sq + 2*ph*n
  end
  result
end

# The search might be faster by constructing the primes in order and
# grabbing as many as are needed to test for primality.

class Search
  def initialize
    # setup for 1x1 square.
    @diags = 1
    @primes = 0
    @size = 0
  end

  def each
    loop do
      bump
      yield (2*@size+1), Rational(@primes, @diags)
    end
  end

  def bump
    @size += 1
    p = diags @size
    @primes += p.count {|x| x.prime?}
    @diags += 4
  end
end

Search.new.each do |size, r|
  # printf "%3d %9.3f\n", size, (r * 100)
  if r < Rational(1, 10)
    printf "%3d %9.3f\n", size, (r * 100)
    break
  end
end
