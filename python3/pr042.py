#! /usr/bin/env python3

"""
Problem 42

25 April 2003


The n^th term of the sequence of triangle numbers is given by, t[n] = ½n(n
+1); so the first ten triangle numbers are:

1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...

By converting each letter in a word to a number corresponding to its
alphabetical position and adding these values we form a word value. For
example, the word value for SKY is 19 + 11 + 25 = 55 = t[10]. If the word
value is a triangle number then we shall call the word a triangle word.

Using words.txt (right click and 'Save Link/Target As...'), a 16K text
file containing nearly two-thousand common English words, how many are
triangle words?

162
"""

import misc

def main():
    with open('../haskell/words.txt', 'r') as fd:
        words = fd.read()
    words = [word.strip('"') for word in words.split(',')]
    count = 0
    for word in words:
        if is_triangle(word_value(word)):
            count += 1
    print(count)

def word_value(word):
    total = 0
    for ch in word:
        total += ord(ch) - ord('A') + 1
    return total

def is_triangle(number):
    sqr = 1 + number * 8
    root = misc.isqrt(sqr)
    return sqr == root**2

if __name__ == '__main__':
    main()
