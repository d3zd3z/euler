# Problem 17
#
# 17 May 2002
#
#
# If the numbers 1 to 5 are written out in words: one, two, three, four,
# five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
#
# If all the numbers from 1 to 1000 (one thousand) inclusive were written
# out in words, how many letters would be used?
#
#
# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and
# forty-two) contains 23 letters and 115 (one hundred and fifteen) contains
# 20 letters. The use of "and" when writing out numbers is in compliance
# with British usage.
#
# 21124

const ones = [
   "one", "two", "three", "four", "five", "six", "seven",
   "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen",
   "fifteen", "sixteen", "seventeen", "eighteen", "nineteen" ]

const tens = [
   "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty",
   "ninety" ]

function spoken(num)
   if num == 1000
      return "one thousand"
   elseif num <= 0
      error("Unsupported number")
   elseif num < 20
      ones[num]
   elseif num < 100 && num % 10 == 0
      tens[div(num, 10) - 1]
   elseif num < 100
      tens[div(num, 10) - 1] * "-" * ones[num % 10]
   elseif num < 1000 && num % 100 == 0
      spoken(div(num, 100)) * " hundred"
   elseif num < 1000
      spoken(div(num, 100)) * " hundred and " * spoken(num % 100)
   else
      error("Unsupported number")
   end
end

function count_letters(text)
   count = 0
   for ch in text
      if isalpha(ch)
         count += 1
      end
   end
   count
end

function solve()
   total = 0
   for n = 1:1000
      total += count_letters(spoken(n))
   end
   total
end

println(solve())
