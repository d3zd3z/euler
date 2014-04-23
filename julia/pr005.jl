# Problem 5
#
# 30 November 2001
#
#
# 2520 is the smallest number that can be divided by each of the numbers
# from 1 to 10 without any remainder.
#
# What is the smallest positive number that is evenly divisible by all of
# the numbers from 1 to 20?
#
# 232792560

function solve()
   total = 1
   for i = 2:20
      total = lcm(total, i)
   end
   total
end

println(solve())
