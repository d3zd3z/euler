# Problem 40
#
# 28 March 2003
#
#
# An irrational decimal fraction is created by concatenating the positive
# integers:
#
# 0.123456789101112131415161718192021...
#
# It can be seen that the 12^th digit of the fractional part is 1.
#
# If d[n] represents the n^th digit of the fractional part, find the value
# of the following expression.
#
# d[1] × d[10] × d[100] × d[1000] × d[10000] × d[100000] × d[1000000]
#
# 210

# This was the old approach.  Construct a generator instead.
# function gen_seq()
#    i = 1
#    while true
#       for dg in reverse!(digits(i))
#          produce(dg)
#       end
#       i += 1
#    end
# end

import Base: iterate

struct State
    cur :: Int
    work :: Union{Nothing, Vector{Int}}
end

struct Gen
end

function iterate(g::Gen, st::State=State(1, nothing))
   cur = st.cur
   work = st.work
   if work === nothing
      work = digits(cur)
      cur = cur + 1
   end
   dig = pop!(work)
   if isempty(work)
      work = nothing
   end
   (dig, State(cur, work))
end

function solve()
   total = 1
   pos = 1
   stop = 1
   # for dg in Task(gen_seq)
   for dg in Gen()
      if pos == stop
         total *= dg
         stop *= 10
         if stop > 1_000_000
            break
         end
      end
      pos += 1
   end
   total
end

println(solve())
