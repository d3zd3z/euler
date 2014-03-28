#! /usr/bin/env python3

"""
Problem 35

17 January 2003


The number, 197, is called a circular prime because all rotations of the
digits: 197, 971, and 719, are themselves prime.

There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37,
71, 73, 79, and 97.

How many circular primes are there below one million?

55
"""

from sieve import Sieve

def main():
    sv = Sieve()

    count = 0
    for p in sv.prime_range(2, 1000000):
        if all(sv.is_prime(i) for i in number_rotations(p)):
            count += 1
    print(count)

def number_rotations(num):
    size = digit_count(num)
    highest_one = 10 ** (size-1)

    right = highest_one
    left = 1
    accum = 0
    while left < highest_one:
        n_quot = num // 10
        n_rem = num % 10
        accum = accum + left * n_rem
        nextn = n_quot + right * accum

        right //= 10
        left *= 10
        num = n_quot
        yield nextn

def digit_count(num):
    result = 0
    while num > 0:
        result += 1
        num //= 10
    return result

if __name__ == '__main__':
    main()
