# Problem 50
#
# 15 August 2003
#
#
# The prime 41, can be written as the sum of six consecutive primes:
#
# 41 = 2 + 3 + 5 + 7 + 11 + 13
#
# This is the longest sum of consecutive primes that adds to a prime below
# one-hundred.
#
# The longest sum of consecutive primes below one-thousand that adds to a
# prime, contains 21 terms, and is equal to 953.
#
# Which prime, below one-million, can be written as the sum of the most
# consecutive primes?
#
# 997651

function solve()
   cap = 1000000

   ps = primes(cap)

   longest_len = 0
   longest_val = 0

   for a = 1:endof(ps)
      total = 0
      for b = a:endof(ps)
         total += ps[b]
         if total >= cap
            break
         end

         if (b-a+1) > longest_len && isprime(total)
            longest_len = b-a+1
            longest_val = total
         end
      end
   end

   longest_val
end

println(solve())
