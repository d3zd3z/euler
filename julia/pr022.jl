# Problem 22
#
# 19 July 2002
#
#
# Using names.txt (right click and 'Save Link/Target As...'), a 46K text
# file containing over five-thousand first names, begin by sorting it into
# alphabetical order. Then working out the alphabetical value for each name,
# multiply this value by its alphabetical position in the list to obtain a
# name score.
#
# For example, when the list is sorted into alphabetical order, COLIN, which
# is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So,
# COLIN would obtain a score of 938 × 53 = 49714.
#
# What is the total of all the name scores in the file?
#
# 871198282

function get_names()
   ns = open("../haskell/names.txt") do fd
      readuntil(fd, "\n")
   end
   ns = split(ns, ',')
   ns = map(n->strip(n, '"'), ns)
   sort!(ns)
end

function name_value(name)
   total = 0
   for ch in name
      total += ch - 'A' + 1
   end
   total
end

function solve()
   names = get_names()
   total = 0
   for i = 1:lastindex(names)
      total += i * name_value(names[i])
   end
   total
end

println(solve())
