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

function gen_seq()
   i = 1
   while true
      for dg in reverse!(digits(i))
         produce(dg)
      end
      i += 1
   end
end

function solve()
   total = 1
   pos = 1
   stop = 1
   for dg in Task(gen_seq)
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
