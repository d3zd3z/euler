#! /usr/bin/env python3
# coding=utf8

"""
Problem 14

05 April 2002


The following iterative sequence is defined for the set of positive
integers:

n → n/2 (n is even)
n → 3n + 1 (n is odd)

Using the rule above and starting with 13, we generate the following
sequence:

13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1

It can be seen that this sequence (starting at 13 and finishing at 1)
contains 10 terms. Although it has not been proved yet (Collatz Problem),
it is thought that all starting numbers finish at 1.

Which starting number, under one million, produces the longest chain?

NOTE: Once the chain starts the terms are allowed to go above one million.

837799
"""

def chain_len(n):
    len = 1
    while n != 1:
        len += 1
        if (n & 1) == 0:
            n //= 2
        else:
            n = n * 3 + 1
    return len

# Memozied version.
def cached_lengther():
    cache = {}
    def clen(n):
        if n > 10240:
            return inner_len(n)
        if n in cache:
            return cache[n]
        result = inner_len(n)
        cache[n] = result
        return result
    def inner_len(n):
        if n == 1:
            return 1
        elif (n & 1) == 0:
            return 1 + clen(n // 2)
        else:
            return 1 + clen(n * 3 + 1)
    return clen

# Try memoize with a different cache formulation.
def array_lengther():
    cache = [None for x in range(10240)]
    def clen(n):
        if n >= len(cache):
            return inner_len(n)
        result = cache[n]
        if result:
            return result
        result = inner_len(n)
        cache[n] = result
        return result
    def inner_len(n):
        if n == 1:
            return 1
        elif (n & 1) == 0:
            return 1 + clen(n // 2)
        else:
            return 1 + clen(n * 3 + 1)
    return clen

def longest(func):
    largest = 0
    largest_value = 0
    for i in range(1, 1000000):
        tmp = func(i)
        if tmp > largest:
            largest = tmp
            largest_value = i
    return largest_value

# With pypy, the basic version seems fastest, still about half the
# speed of luajit.
# With cpython, the cached_lengther seems to be the fastest,
# especially with a very large cache (1 million).

def main():
    print(longest(chain_len))
    # print(longest(cached_lengther()))
    # print(longest(array_lengther()))

if __name__ == '__main__':
    main()
