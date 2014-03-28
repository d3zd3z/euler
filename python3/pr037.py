#! /usr/bin/env python3

"""
Problem 37

14 February 2003


The number 3797 has an interesting property. Being prime itself, it is
possible to continuously remove digits from left to right, and remain
prime at each stage: 3797, 797, 97, and 7. Similarly we can work from
right to left: 3797, 379, 37, and 3.

Find the sum of the only eleven primes that are both truncatable from left
to right and right to left.

NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.

748317
"""

import mrabin
import misc

def main():
    rights = right_truncatable_primes()
    rights = [x for x in rights if x > 9 if is_left_truncatable(x)]
    print(sum(rights))

def right_truncatable_primes():
    result = []
    progress = [2, 3, 5, 7]

    while len(progress) > 0:
        result.extend(progress)
        progress = add_primes(progress)
    return result

def add_primes(numbers):
    result = []
    for number in numbers:
        for extra in [1, 3, 7, 9]:
            n = number * 10 + extra
            if mrabin.is_prime(n):
                result.append(n)
    return result

def is_left_truncatable(number):
    while number > 0:
        if number == 1 or not mrabin.is_prime(number):
            return False

        tmp = misc.reverse_number(number)
        number = misc.reverse_number(tmp // 10)
    return True

if __name__ == '__main__':
    main()
