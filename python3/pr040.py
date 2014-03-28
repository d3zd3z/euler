#! /usr/bin/env python3

"""
Problem 40

28 March 2003


An irrational decimal fraction is created by concatenating the positive
integers:

0.123456789101112131415161718192021...

It can be seen that the 12^th digit of the fractional part is 1.

If d[n] represents the n^th digit of the fractional part, find the value
of the following expression.

d[1] × d[10] × d[100] × d[1000] × d[10000] × d[100000] × d[1000000]

210
"""

def main():
    steps = set([1, 10, 100, 1000, 10000, 100000, 1000000])
    d = 1
    total = 1
    for ch in digits():
        if d in steps:
            total *= int(ch)
            steps.remove(d)
            if len(steps) == 0:
                break
        d += 1
    print(total)

def digits():
    i = 1
    while True:
        for ch in str(i):
            yield ch
        i += 1

if __name__ == '__main__':
    main()
