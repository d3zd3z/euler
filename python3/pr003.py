#! /usr/bin/env python3

######################################################################
# Problem 3
# 
# 02 November 2001
# 
# 
# The prime factors of 13195 are 5, 7, 13 and 29.
# 
# What is the largest prime factor of the number 600851475143 ?
######################################################################
# 6857

def main():
    n = 600851475143
    p = 3  # n is not even.

    while n > 1:
        if n % p == 0:
            n /= p
        else:
            p += 2

    print(p)

if __name__ == '__main__':
    main()
