# Problem 34
#
# 03 January 2003
#
#
# 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
#
# Find the sum of all numbers which are equal to the sum of the factorial of
# their digits.
#
# Note: as 1! = 1 and 2! = 2 are not sums they are not included.
#
# 40730

type State
   total :: Int64
   facts :: Vector{Int64}
   last_fact :: Int64

   function State()
      facts = map(factorial, 0:9)
      # Start the total with -1 to avoid including 1! and 2! as per
      # the problem description.
      new(-3, facts, facts[end])
   end
end

function chain(state, number, fact_sum)
   if number > 0 && number == fact_sum
      state.total += number
   end
   if number * 10 <= fact_sum + state.last_fact
      for i = (number > 0 ? 0 : 1):9
         chain(state, number * 10 + i, fact_sum + state.facts[i + 1])
      end
   end
end

function solve()
   chainer = State()
   chain(chainer, 0, 0)
   chainer.total
end

println(solve())
