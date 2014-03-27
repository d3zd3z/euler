#! /usr/bin/env python3

"""
Problem 32

06 December 2002


We shall say that an n-digit number is pandigital if it makes use of all
the digits 1 to n exactly once; for example, the 5-digit number, 15234, is
1 through 5 pandigital.

The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing
multiplicand, multiplier, and product is 1 through 9 pandigital.

Find the sum of all products whose multiplicand/multiplier/product
identity can be written as a 1 through 9 pandigital.

HINT: Some products can be obtained in more than one way so be sure to
only include it once in your sum.

45228
"""

from __future__ import print_function

from itertools import permutations

def main():
    result = set()
    for digits in permutations('123456789'):
        make_groupings(digits, result)

    print(sum(result))

def make_groupings(digits, result):
    digits = ''.join(digits)
    def piece(a, b):
        return int(digits[a:b])
    size = len(digits)
    for i in range(1, size-2):
        # Turns out that the only meaningful position for j is 5.
        for j in range(i+1, size-1):
            a = piece(0, i)
            b = piece(i, j)
            c = piece(j, size)
            if a*b == c:
                # print(a, b, c)
                result.add(c)

if __name__ == '__main__':
    main()
