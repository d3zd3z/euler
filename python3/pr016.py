#! /usr/bin/env python3

"""
Problem 16

03 May 2002

2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

What is the sum of the digits of the number 2^1000?

1366
"""

def main():
    number = 2 ** 1000
    total = 0
    while number > 0:
        total += number % 10
        number //= 10
    print(total)

if __name__ == '__main__':
    main()
