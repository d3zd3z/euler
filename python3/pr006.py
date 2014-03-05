#! /usr/bin/env python3

"""
Problem 6

14 December 2001


The sum of the squares of the first ten natural numbers is,

1^2 + 2^2 + ... + 10^2 = 385

The square of the sum of the first ten natural numbers is,

(1 + 2 + ... + 10)^2 = 55^2 = 3025

Hence the difference between the sum of the squares of the first ten
natural numbers and the square of the sum is 3025 − 385 = 2640.

Find the difference between the sum of the squares of the first one
hundred natural numbers and the square of the sum.
"""

# 25164150

limit = 100

def iterative():
    squares = 0
    sums = 0
    for i in range(1, limit+1):
        squares += i * i
        sums += i
    sums = sums * sums
    return sums - squares

def functional():
    squares = sum([i * i for i in range(1, limit + 1)])
    sums = sum([i for i in range(1, limit + 1)])
    sums = sums * sums
    return sums - squares

def main():
    # print(iterative())
    print(functional())

if __name__ == '__main__':
    main()
