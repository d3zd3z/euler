# Problem 42
#
# 25 April 2003
#
#
# The n^th term of the sequence of triangle numbers is given by, t[n] = ½n(n
# +1); so the first ten triangle numbers are:
#
# 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
#
# By converting each letter in a word to a number corresponding to its
# alphabetical position and adding these values we form a word value. For
# example, the word value for SKY is 19 + 11 + 25 = 55 = t[10]. If the word
# value is a triangle number then we shall call the word a triangle word.
#
# Using words.txt (right click and 'Save Link/Target As...'), a 16K text
# file containing nearly two-thousand common English words, how many are
# triangle words?
#
# 162

function is_triangle(number)
   sqr = 1 + 8 * number
   root = isqrt(sqr)
   sqr == root * root
end

function name_value(name)
   total = 0
   for ch in name
      total += ch - 'A' + 1
   end
   total
end

function solve()
   block = open("../haskell/words.txt") do fd
      readall(fd)
   end
   words = split(block, ',')
   map!(x->strip(x, '"'), words)

   count = 0
   for word in words
      if is_triangle(name_value(word))
         count += 1
      end
   end
   count
end

println(solve())
