#! /usr/bin/env python3

"""
Problem 26

13 September 2002


A unit fraction contains 1 in the numerator. The decimal representation of
the unit fractions with denominators 2 to 10 are given:

    ^1/[2]  =  0.5
    ^1/[3]  =  0.(3)
    ^1/[4]  =  0.25
    ^1/[5]  =  0.2
    ^1/[6]  =  0.1(6)
    ^1/[7]  =  0.(142857)
    ^1/[8]  =  0.125
    ^1/[9]  =  0.(1)
    ^1/[10] =  0.1

Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can
be seen that ^1/[7] has a 6-digit recurring cycle.

Find the value of d < 1000 for which ^1/[d] contains the longest recurring
cycle in its decimal fraction part.

983
"""

from sieve import Sieve

def main():
    s = Sieve()

    largest = 0
    largets_value = 0

    for p in s.prime_range(7, 1000):
        size = tenlog(p)
        if size > largest:
            largest = size
            largest_value = p

    print(largest_value)

def tenlog(n):
    """
    Solve 10**k = 1 (mod n).

    For a given number n, the repeat length of 1/n is the solution to
    'k' in the above equation.  For a composite number, the length
    will merely be the longest length of any of its factors, so there
    isn't a need to test compositve values.  This will, however, fail
    to terminate if the value passed has 2 or 5 as factors.
    """
    result = 1
    temp = 10 % n

    while temp != 1:
        result += 1
        temp = (temp * 10) % n
    return result

if __name__ == '__main__':
    main()
