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

import
  ropes,
  strutils

const ones = [
  "one", "two", "three", "four", "five", "six", "seven", "eight",
  "nine", "ten", "eleven", "twelve", "thirteen", "fourteen",
  "fifteen", "sixteen", "seventeen", "eighteen", "nineteen" ]

const tens = [
  "ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy",
  "eighty", "ninety" ]

proc toEnglish(n: int): string =
  var
    buffer: PRope
    addSpace = false
    work = n

  proc add(text: string) =
    if addSpace:
      buffer.add(" ")
    buffer.add(text)
    addSpace = true

  if work > 1000:
    quit "Number too large"

  if work == 1000:
    return "one thousand"

  if work >= 100:
    add(ones[work div 100 - 1])
    add("hundred")
    work = work mod 100
    if work > 0:
      add("and")

  if work >= 20:
    add(tens[work div 10 - 1])
    work = work mod 10
    if work > 0:
      addSpace = false
      add("-")
      addSpace = false

  if work >= 1:
    add(ones[work - 1])

  result = $buffer

proc countLetters(text: string): int =
  for ch in text:
    if ch in Letters:
      result += 1

proc solve =
  var total = 0
  for i in 1..1000:
    let text = toEnglish(i)
    total += countLetters(text)
  echo(total)

when isMainModule:
  solve()
