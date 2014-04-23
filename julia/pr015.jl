# Problem 15
#
# 19 April 2002
#
#
# Starting in the top left corner of a 2×2 grid, there are 6 routes (without
# backtracking) to the bottom right corner.
#
# [p_015]
#
# How many routes are there through a 20×20 grid?
#
# 137846528820

const steps = 20

function bump(values)
   for i in 1:steps
      values[i+1] += values[i]
   end
end

function solve()
   base = ones(Int64, steps + 1)
   for i = 1:steps
      bump(base)
   end
   base[end]
end

println(solve())
