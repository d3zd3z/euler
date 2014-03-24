#! /usr/bin/env python3

"""
Problem 21

05 July 2002


Let d(n) be defined as the sum of proper divisors of n (numbers less than
n which divide evenly into n).
If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair
and each of a and b are called amicable numbers.

For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22,
44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1,
2, 4, 71 and 142; so d(284) = 220.

Evaluate the sum of all the amicable numbers under 10000.

31626
"""

from sieve import Sieve

def is_amicable(self, a):
    b = self.proper_divisor_sum(a)
    if a == b or b == 0:
        return False
    return a == self.proper_divisor_sum(b)
Sieve.is_amicable = is_amicable

def main():
    sum = 0
    s = Sieve()
    for i in range(1, 10000):
        if s.is_amicable(i):
            sum += i
    print(sum)

# A faster way of solving this is to pre-compute all of the divisor
# sums.
# Simple performance comparison shows this is more than 100x faster.

def make_divisors(limit):
    result = [1] * limit
    result[0] = None
    for i in range(2, limit):
        for j in range(i + i, limit, i):
            result[j] += i
    return result

def is_amicable2(sums, a):
    b = sums[a]
    if a == b or b >= len(sums):
        return False
    return a == sums[b]

def main2():
    total = 0
    limit = 10000
    sums = make_divisors(limit)
    for i in range(1, limit):
        if is_amicable2(sums, i):
            total += i
    print(total)

if __name__ == '__main__':
    main()
