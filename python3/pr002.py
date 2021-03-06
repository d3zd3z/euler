#! /usr/bin/env python3
#####################################################################
# Problem 2
#
# 19 October 2001
#
# Each new term in the Fibonacci sequence is generated by adding the
# previous two terms. By starting with 1 and 2, the first 10 terms
# will be:
#
# 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
#
# By considering the terms in the Fibonacci sequence whose values do
# not exceed four million, find the sum of the even-valued terms.
#
# 4613732
#####################################################################

def solve():
    a = 1
    b = 1
    total = 0
    while b < 4000000:
        if (b & 1) == 0:
            total += b
        tmp = a + b
        a = b
        b = tmp
    return total

if __name__ == '__main__':
    print(solve())
