#! /usr/bin/env python3
#####################################################################
# Problem 1
#
# 05 October 2001
#
# If we list all the natural numbers below 10 that are multiples of 3
# or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
#
# Find the sum of all the multiples of 3 or 5 below 1000.
#
# 234168
#####################################################################

def proper(x):
    return (x % 5 == 0) or (x % 3 == 0)

def main():
    result = sum([x for x in range(1, 1000) if proper(x)])
    print(result)

if __name__ == '__main__':
    main()
