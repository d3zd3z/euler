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

proc makeOnes(): seq[int] =
  result = newSeq[int](steps + 1)
  for i in 0 .. steps:
    result[i] = 1

proc bump(values: var seq[int]) =
  for i in 0 .. steps-1:
    values[i+1] += values[i]

proc solve() =
  var values = makeOnes()
  for i in 1 .. steps:
    bump(values)
  let answer = values[values.len-1]
  echo(answer)

solve()
