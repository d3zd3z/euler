# Problem 48
#
# 18 July 2003
#
#
# The series, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.
#
# Find the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000^1000.
#
# 9110846700

const modulus = 10^10

function solve()
   total = 0
   for i = 1:1000
      total = (total + powermod(i, i, modulus)) % modulus
   end
   total
end

println(solve())
