#! /usr/bin/env python3

"""
Problem 39

14 March 2003


If p is the perimeter of a right angle triangle with integral length
sides, {a,b,c}, there are exactly three solutions for p = 120.

{20,48,52}, {24,45,51}, {30,40,50}

For which value of p ≤ 1000, is the number of solutions maximised?

840
"""

import triangle

def main():
    mapping = {}
    for tri, circ in triangle.triples(1000):
        mapping[circ] = 1 + mapping.get(circ, 0)

    # Find the one with the largest number of triangles.
    big = 0
    bigc = 0
    for k, v in mapping.items():
        if v > bigc:
            bigc = v
            big = k
    print(big)

if __name__ == '__main__':
    main()
