#! /usr/bin/env ruby19
#
# The arithmetic sequence, 1487, 4817, 8147, in which each of the
# terms increases by 3330, is unusual in two ways: (i) each of the
# three terms are prime, and, (ii) each of the 4-digit numbers are
# permutations of one another.
#
# There are no arithmetic sequences made up of three 1-, 2-, or
# 3-digit primes, exhibiting this property, but there is one other
# 4-digit increasing sequence.
#
# What 12-digit number do you form by concatenating the three terms in
# this sequence?
######################################################################

require 'prime'

# Are these numbers permutations of each other?
def perm?(a, b)
  a.to_s.chars.sort == b.to_s.chars.sort
end

# Gather all of the numbers out of rest that are a permutation of
# 'first'.  Invokes the block with arguments of each permutation.
def perm_pairs(first, rest, &block)
  res = [first]
  perms = rest.select { |other| perm?(first, other) }
  perms.permutation(2, &block)
end

def scan(nums)
  nums = nums.dup

  while nums.length >= 3
    first = nums.shift
    perm_pairs(first, nums) do |rest|
      if 2*rest[0] - first == rest[1]
        # The desired answer is the concatenation of all of these.
        answer = first.to_s
        answer += rest[0].to_s
        answer += rest[1].to_s
        puts answer unless answer == "148748178147"
      end
    end
  end
end

begin
  pnums = Prime.each(9999).select { |x| x >= 1000 }
  scan pnums
end
