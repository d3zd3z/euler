# Problem 39
#
# 14 March 2003
#
#
# If p is the perimeter of a right angle triangle with integral length
# sides, {a,b,c}, there are exactly three solutions for p = 120.
#
# {20,48,52}, {24,45,51}, {30,40,50}
#
# For which value of p ≤ 1000, is the number of solutions maximised?
#
# 840

import Base.Threads: @spawn
import Base: *

# Triangle support.
struct Triple{T}
   nums :: Array{T, 1}
end

# Box is used in Julia already.
struct TBox{T}
   box::Array{T, 2}
end

const init_box = TBox([1 1 ; 2 3])

circumference(t::Triple) = sum(t.nums)
*(t::Triple{T}, k::T) where T = Triple(t.nums .* k)

# Get the triangle out of a box.
function triangle(t::TBox)
   box = t.box
   Triple([2 * box[1,1] * box[2,1],
      box[1,2] * box[2,2],
      box[1,1] * box[2,2] + box[2,1] * box[1,2]])
end

# Each box generates 3 children.
function children(t::TBox)
   x = t.box[1,2]
   y = t.box[2,2]
   [ TBox([ y-x  x;   y  2y-x ]),
     TBox([   x  y; x+y  2x+y ]),
     TBox([   y  x; y+x  2y+x ]) ]
end

# Generate all of the primitive Pythagorean triples with a
# circumference <= limit.  Returns tuples of (Triple{T}, T) for the
# triangle and its circumference.
function primitive_generator(dest, limit)
   work = [init_box]
   while !isempty(work)
      abox = pop!(work)
      triple = triangle(abox)
      size = circumference(triple)
      if size <= limit
         put!(dest, (triple, size))
         append!(work, children(abox))
      end
   end
   close(dest)
end

# Generate all of the triples up to and including the limit.
function generate_triples(dest, limit)
   subch = Channel()
   @spawn primitive_generator(subch, limit)
   for (tri, circ) in subch
      k = 1
      while true
         kcirc = k * circ
         if kcirc > limit
            break
         end
         put!(dest, ((tri * k, kcirc)))
         k += 1
      end
   end
   close(dest)
end

using DataStructures

function solve()
   ac = counter(Int64)
   ch = Channel()
   @spawn generate_triples(ch, 1000)
   for (tri, circ) in ch
      push!(ac, circ)
   end

   # Find which circumference has the largest number of solutions.
   pmax = 0
   pcount = 0
   for (p, count) in ac
      if count > pcount
         pmax = p
         pcount = count
      end
   end
   pmax

end

@time println(solve())
