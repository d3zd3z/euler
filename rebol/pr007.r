#! /usr/bin/env r3

REBOL [
    Title: "Problem 7"

    Description: {
         Problem 7

         28 December 2001

         By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
         that the 6th prime is 13.

         What is the 10 001st prime number?

    }

    Solution: 104743

    Needs: %sieve.r
]

solve: funct [] [
    sv: make-sieve
    p: 2
    count: 1
    while [count < 10001] [
	count: count + 1
	p: sv/next-prime p
    ]
    p
]

print solve
