#! /usr/bin/env python3

"""
Problem 23

02 August 2002


A perfect number is a number for which the sum of its proper divisors is
exactly equal to the number. For example, the sum of the proper divisors
of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect
number.

A number n is called deficient if the sum of its proper divisors is less
than n and it is called abundant if this sum exceeds n.

As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the
smallest number that can be written as the sum of two abundant numbers is
24. By mathematical analysis, it can be shown that all integers greater
than 28123 can be written as the sum of two abundant numbers. However,
this upper limit cannot be reduced any further by analysis even though it
is known that the greatest number that cannot be expressed as the sum of
two abundant numbers is less than this limit.

Find the sum of all the positive integers which cannot be written as the
sum of two abundant numbers.

4179871
"""

def make_divisors(limit):
    result = [1] * limit
    result[0] = None
    for i in range(2, limit):
        for j in range(i + i, limit, i):
            result[j] += i
    return result

def make_abundants(limit):
    divisors = make_divisors(limit)
    result = []
    for i in range(1, limit):
        if i < divisors[i]:
            result.append(i)
    return result

def main():
    abundants = make_abundants(28124)

    not_add = set()
    for ai in range(len(abundants)):
        a = abundants[ai]
        for bi in range(ai, len(abundants)):
            both = a + abundants[bi]
            if both > 28123:
                break
            not_add.add(both)

    total = 0
    for i in range(1, 28124):
        if i not in not_add:
            total += i

    print(i)

if __name__ == '__main__':
    main()
