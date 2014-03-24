#! /usr/bin/env python3

"""
Problem 22

19 July 2002

Using names.txt (right click and 'Save Link/Target As...'), a 46K text
file containing over five-thousand first names, begin by sorting it into
alphabetical order. Then working out the alphabetical value for each name,
multiply this value by its alphabetical position in the list to obtain a
name score.

For example, when the list is sorted into alphabetical order, COLIN, which
is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So,
COLIN would obtain a score of 938 × 53 = 49714.

What is the total of all the name scores in the file?

871198282
"""

import itertools

def name_value(name):
    total = 0
    for ch in name:
        total += ord(ch) - ord('A') + 1
    return total

def main():
    with open('../haskell/names.txt', 'r') as fd:
        names = fd.read()
    names = [name.strip('"') for name in names.split(',')]
    names.sort()
    names = [name_value(name) * pos for name, pos in zip(names, itertools.count(1))]
    print(sum(names))

if __name__ == '__main__':
    main()
