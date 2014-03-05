#! /usr/bin/env python3

"""
Problem 10

08 February 2002


The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

Find the sum of all the primes below two million.
"""
# 142913828922

from sieve import Sieve

def main():
    s = Sieve()
    sum = 0
    prime = 2

    while prime < 2000000:
        sum += prime
        prime = s.next_prime(prime)

    print(sum)

if __name__ == '__main__':
    main()
