#! /usr/bin/env python3

"""
Problem 38

28 February 2003


Take the number 192 and multiply it by each of 1, 2, and 3:

    192 × 1 = 192
    192 × 2 = 384
    192 × 3 = 576

By concatenating each product we get the 1 to 9 pandigital, 192384576. We
will call 192384576 the concatenated product of 192 and (1,2,3)

The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4,
and 5, giving the pandigital, 918273645, which is the concatenated product
of 9 and (1,2,3,4,5).

What is the largest 1 to 9 pandigital 9-digit number that can be formed as
the concatenated product of an integer with (1,2, ... , n) where n > 1?

932718654
"""

def main():
    largest = 0
    for i in range(1, 10000):
        big = large_sum(i)
        if big > largest and is_pandigital(big):
            largest = big
    print(largest)

def large_sum(base):
    """Given a 'base' according to the problem, multiply successibly
    by digits starting with 1 until we reach >= 9 digits."""
    result = 0
    x = 1
    while result < 100000000:
        result = decimal_concatenate(result, base * x)
        x += 1
    return result

def is_pandigital(number):
    """Is this number a full 9-element pandigital number."""
    # Compute by collecting each digit, and tracking them as bits in a
    # value, making sure no bits are set twice, and at the end, that
    # all of the desired bits are set.
    bits = 0
    while number > 0:
        m = number % 10
        bit = 1 << m
        if (bits & bit) != 0:
            return False
        bits |= bit
        number //= 10
    return bits == 1022

def decimal_concatenate(a, b):
    """Concatenate the two numbers in decimal."""
    tmp = b
    while tmp > 0:
        a *= 10
        tmp //= 10
    return a + b

if __name__ == '__main__':
    assert(is_pandigital(192384576))
    assert(not is_pandigital(1923845767))
    assert(not is_pandigital(19238456))
    assert(decimal_concatenate(12345, 67) == 1234567)
    main()
