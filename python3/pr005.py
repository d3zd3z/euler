#! /usr/bin/env python3

"""
Problem 5

30 November 2001


2520 is the smallest number that can be divided by each of the numbers
from 1 to 10 without any remainder.

What is the smallest positive number that is evenly divisible by all of
the numbers from 1 to 20?
"""

# 232792560

def gcd(a, b):
    if b == 0:
        return a
    else:
        return gcd(b, a % b)

def lcm(a, b):
    return a // gcd(a, b) * b

def main():
    result = 1
    for i in range(2, 21):
        result = lcm(result, i)
    print(result)

if __name__ == '__main__':
    main()
