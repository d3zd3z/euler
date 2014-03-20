#! /usr/bin/env python3

"""
Problem 15

19 April 2002


Starting in the top left corner of a 2×2 grid, there are 6 routes (without
backtracking) to the bottom right corner.

[p_015]

How many routes are there through a 20×20 grid?

137846528820
"""

steps = 20

def bump (values):
    for i in range(steps):
        values[i+1] = values[i+1] + values[i]

def main():
    values = [1 for i in range(steps + 1)]
    for i in range(steps):
        bump(values)
    print(values[steps])

if __name__ == '__main__':
    main()
