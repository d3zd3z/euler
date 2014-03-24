#! /usr/bin/env python3

"""
A simple prime number sieve.
"""

from collections import namedtuple

# Using bitarray will use a lot less memory, but is actually slower.

Factor = namedtuple('Factor', ['prime', 'power'])

class Sieve:

    def __init__(self):
        self._fill(8192)

    def _fill(self, limit):
        bits = [True] * limit
        bits[0] = False
        bits[1] = False

        pos = 2
        while pos < limit:
            if not bits[pos]:
                pos += 2
            else:
                n = pos + pos
                while n < limit:
                    bits[n] = False
                    n += pos
                if pos == 2:
                    pos += 1
                else:
                    pos += 2
        self.bits = bits

    def _check(self, n):
        limit = len(self.bits)
        if n >= limit:
            while n >= limit:
                limit *= 8
            self._fill(limit)

    def is_prime(self, n):
        self._check(n)
        return self.bits[n]

    def next_prime(self, n):
        if n == 2:
            return 3
        n += 2
        while not self.is_prime(n):
            n += 2
        return n

    def divisor_count(self, n):
        result = 1
        p = 2
        while n > 1:
            divide_count = 0
            while n % p == 0:
                divide_count += 1
                n //= p
            result *= (divide_count + 1)
            p = self.next_prime(p)
        return result

    def factorize(self, n):
        result = []
        prime = 2
        count = 0

        while n > 1:
            if n % prime == 0:
                n //= prime
                count += 1
            else:
                if count > 0:
                    result.append(Factor(prime, count))
                    count = 0
                if n > 1:
                    prime = self.next_prime(prime)

        if count > 0:
            result.append(Factor(prime, count))

        return result

    def divisors(self, n):
        factors = self.factorize(n)
        result = []
        self.__spread(factors, result)
        result.sort()
        return result

    def __spread(self, factors, result):
        if len(factors) == 0:
            result.append(1)
        else:
            rest = []
            x = factors[0]
            self.__spread(factors[1:], rest)

            power = 1
            for i in range(x.power + 1):
                result.extend(elt * power for elt in rest)
                if i < x.power:
                    power *= x.prime

    def proper_divisor_sum(self, n):
        return sum(self.divisors(n)) - n

def test():
    sv = Sieve()
    # print(sv.bits)
    print(sv.divisor_count(120))
    print(sv.factorize(120))
    print('divisors', sv.divisors(120))

if __name__ == '__main__':
    test()
