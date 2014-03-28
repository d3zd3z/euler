#! /usr/bin/env python3

"""
Problem 41

11 April 2003


We shall say that an n-digit number is pandigital if it makes use of all
the digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital
and is also prime.

What is the largest n-digit pandigital prime that exists?

7652413
"""

from sieve import Sieve

# 8 and 9 digit pandigital numbers will always be divisible by 3, so
# the largest this can be is a 7-digit number.

def main():
    largest = 0
    for p in Sieve().prime_range(2, 9999999):
        if is_pandigital(p):
            largest = p
    print(largest)

def is_pandigital(num):
    digits = [0] * 10
    count = 0
    while num > 0:
        digits[num % 10] += 1
        count += 1
        num //= 10

    if digits[0] > 0:
        return False

    for i in range(1, count+1):
        if digits[i] != 1:
            return False

    return True

if __name__ == '__main__':
    main()
