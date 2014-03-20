#! /usr/bin/env python3

"""
Problem 20

21 June 2002


n! means n × (n − 1) × ... × 3 × 2 × 1

For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 =
27.

Find the sum of the digits in the number 100!

648
"""

def main():
    big = 1
    for i in range(2, 101):
        big *= i
    total = 0
    while big > 0:
        total += big % 10
        big //= 10
    print(total)

if __name__ == '__main__':
    main()
