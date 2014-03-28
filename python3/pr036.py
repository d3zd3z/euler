#! /usr/bin/env python3

"""
Problem 36

31 January 2003


The decimal number, 585 = 1001001001[2] (binary), is palindromic in both
bases.

Find the sum of all numbers, less than one million, which are palindromic
in base 10 and base 2.

(Please note that the palindromic number, in either base, may not include
leading zeros.)

872187
"""

import misc

def main():
    total = 0
    for i in range(1, 1000000):
        if misc.is_palindrome(i, 10) and misc.is_palindrome(i, 2):
            total += i
    print(total)

if __name__ == '__main__':
    main()
