#! /usr/bin/env python3

"""
Problem 7

28 December 2001


By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
that the 6th prime is 13.

What is the 10 001st prime number?
"""

from sieve import Sieve

def main():
    s = Sieve()
    prime = 2
    count = 1

    while count < 10001:
        prime = s.next_prime(prime)
        count += 1

    print(prime)

if __name__ == '__main__':
    main()
