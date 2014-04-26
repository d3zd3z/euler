# Problem 37
#
# 14 February 2003
#
#
# The number 3797 has an interesting property. Being prime itself, it is
# possible to continuously remove digits from left to right, and remain
# prime at each stage: 3797, 797, 97, and 7. Similarly we can work from
# right to left: 3797, 379, 37, and 3.
#
# Find the sum of the only eleven primes that are both truncatable from left
# to right and right to left.
#
# NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
#
# 748317

# Given a list of numbers, return a list of the numbers that are still
# prime when a single digit as appended to the right.
function add_primes{T}(numbers::Vector{T})
   result = T[]
   for n in numbers
      for extra in [1, 3, 7, 9]
         tmp = n * 10 + extra
         if isprime(tmp)
            push!(result, tmp)
         end
      end
   end
   result
end

# Generate a list of all right-truncatable primes.
function right_truncatable_primes()
   result = Int64[]
   work = [2, 3, 5, 7]

   while !isempty(work)
      append!(result, work)
      work = add_primes(work)
   end
   result
end

function numreverse(n)
   result = 0
   while n > 0
      result = result * 10 + mod(n, 10)
      n = div(n, 10)
   end
   result
end

left_truncate(n) = numreverse(div(numreverse(n), 10))

function is_left_truncatable(number)
   while number > 0
      if !isprime(number)
         return false
      end
      number = left_truncate(number)
   end
   true
end

function solve()
   rights = right_truncatable_primes()
   filter!(is_left_truncatable, rights)
   filter!(x -> x > 9, rights)
   sum(rights)
end

println(solve())
