#! /usr/bin/env python3

"""
Problem 28

11 October 2002


Starting with the number 1 and moving to the right in a clockwise
direction a 5 by 5 spiral is formed as follows:

21 22 23 24 25
20  7  8  9 10
19  6  1  2 11
18  5  4  3 12
17 16 15 14 13

It can be verified that the sum of the numbers on the diagonals is 101.

What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral
formed in the same way?

669171001
"""

def main():
    # Account for 1 in the center.
    total = 1

    for a in range(3, 1002, 2):
        total += ring_sum(a)
    print(total)

def ring_sum(n):
    return 4*n*n - 6*n + 6

if __name__ == '__main__':
    main()
