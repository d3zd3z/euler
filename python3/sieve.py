#! /usr/bin/env python3

"""
A simple prime number sieve.
"""

# Using bitarray will use a lot less memory, but is actually slower.

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

def test():
    sv = Sieve()
    # print(sv.bits)
    print(sv.divisor_count(120))

if __name__ == '__main__':
    test()
