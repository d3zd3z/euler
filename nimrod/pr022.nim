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

import algorithm
import strutils

type
  TValue = object
    name: string
    value: int

proc cmpName(a, b: TValue): int =
  cmp(a.name, b.name)

proc getValue(w: string): int =
  for ch in w:
    result += int(ch) - int('A') + 1

proc solve =
  let data = readFile("../haskell/names.txt")
  var words = newSeq[TValue](0)
  for word in split(data, {','}):
    # assume that the quotes are present.
    let w = word[word.low + 1 .. word.high - 1]
    words.add(TValue(name: w, value: getValue(w)))
  sort(words, cmpName)

  var total = 0
  for i in words.low .. words.high:
    total += words[i].value * (i + 1)
  echo total

when isMainModule:
  solve()
