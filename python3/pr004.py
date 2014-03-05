#! /usr/bin/env python3

"""
Problem 4

16 November 2001

A palindromic number reads the same both ways. The largest palindrome made
from the product of two 2-digit numbers is 9009 = 91 x 99.

Find the largest palindrome made from the product of two 3-digit numbers.
"""

# 906609

def reverse_number(x):
    text = bytearray()
    while x > 0:
        text.append(x % 10)
        x //= 10
    result = 0
    for b in text:
        result = result * 10 + b
    return result

def is_palindrome(x):
    return x == reverse_number(x)

def main():
    largest = 0
    for a in range(100, 1000):
        for b in range(a, 1000):
            c = a * b
            if c > largest and is_palindrome(c):
                largest = c
    print(largest)

if __name__ == '__main__':
    main()
