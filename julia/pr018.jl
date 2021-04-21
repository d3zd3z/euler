# Problem 18
#
# 31 May 2002
#
#
# By starting at the top of the triangle below and moving to adjacent
# numbers on the row below, the maximum total from top to bottom is 23.
#
# 3
# 7 4
# 2 4 6
# 8 5 9 3
#
# That is, 3 + 7 + 4 + 9 = 23.
#
# Find the maximum total from top to bottom of the triangle below:
#
#
# NOTE: As there are only 16384 routes, it is possible to solve this problem
# by trying every route. However, Problem 67, is the same challenge with a
# triangle containing one-hundred rows; it cannot be solved by brute force,
# and requires a clever method! ;o)
#
# 1074

# Julia seems to try very hard to build a matrix, rather than an
# array.  To thwart this, put each row in its own type.

struct Row
   elts :: Array{Int64, 1}
end

problem = reverse!([
   Row([75]),
   Row([95, 64]),
   Row([17, 47, 82]),
   Row([18, 35, 87, 10]),
   Row([20, 04, 82, 47, 65]),
   Row([19, 01, 23, 75, 03, 34]),
   Row([88, 02, 77, 73, 07, 63, 67]),
   Row([99, 65, 04, 28, 06, 16, 70, 92]),
   Row([41, 41, 26, 56, 83, 40, 80, 70, 33]),
   Row([41, 48, 72, 33, 47, 32, 37, 16, 94, 29]),
   Row([53, 71, 44, 65, 25, 43, 91, 52, 97, 51, 14]),
   Row([70, 11, 33, 28, 77, 73, 17, 78, 39, 68, 17, 57]),
   Row([91, 71, 52, 38, 17, 14, 91, 43, 58, 50, 27, 29, 48]),
   Row([63, 66, 04, 68, 89, 53, 67, 30, 73, 16, 69, 87, 40, 31]),
   Row([04, 62, 98, 27, 23, 09, 70, 98, 73, 93, 38, 53, 60, 04, 23])
   ], 1)

function combine(a :: Vector{T}, b :: Vector{T}) where T
   result = Vector{T}(undef, length(b))
   for i = 1:lastindex(b)
      result[i] = b[i] + max(a[i], a[i+1])
   end
   result
end

function solve()
   work = problem[1].elts
   for i in 2:lastindex(problem)
      work = combine(work, problem[i].elts)
   end
   work[1]
end

println(solve())
