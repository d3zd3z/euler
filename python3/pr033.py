#! /usr/bin/env python3

"""
Problem 33

20 December 2002


The fraction ^49/[98] is a curious fraction, as an inexperienced
mathematician in attempting to simplify it may incorrectly believe that ^
49/[98] = ^4/[8], which is correct, is obtained by cancelling the 9s.

We shall consider fractions like, ^30/[50] = ^3/[5], to be trivial
examples.

There are exactly four non-trivial examples of this type of fraction, less
than one in value, and containing two digits in the numerator and
denominator.

If the product of these four fractions is given in its lowest common
terms, find the value of the denominator.

100
"""

def gcd(a, b):
    while b > 0:
        a, b = b, a%b
    return a

class Rational():
    def __init__(self, num, den):
        self.num = num
        self.den = den
        self.shrink()

    def __repr__(self):
        return "Rational({},{})".format(self.num, self.den)

    def __mul__(self, other):
        return Rational(self.num * other.num, self.den * other.den)

    def shrink(self):
        common = gcd(self.num, self.den)
        if common > 1:
            self.num //= common
            self.den //= common

def main():
    total = Rational(1, 1)
    for a in range(10, 100):
        for b in range(a+1, 100):
            if is_frac(a, b):
                total *= Rational(a, b)
    print(total.den)

def is_frac(a, b):
    an = a // 10
    am = a % 10
    bn = b // 10
    bm = b % 10
    return ((an == bm and bn > 0 and am*b == bn*a) or
            (am == bn and bm > 0 and an*b == bm*a))

if __name__ == '__main__':
    main()
