#! /usr/bin/env r3

REBOL [
    Title: "Problem 5"

    Description: {
         Problem 5

         30 November 2001

         2520 is the smallest number that can be divided by each of the numbers
         from 1 to 10 without any remainder.

         What is the smallest positive number that is evenly divisible by all of
         the numbers from 1 to 20?

    }

    Solution: 232792560
]

gcd: func [a [integer!] b [integer!] /local tmp] [
    while [b <> 0] [
	tmp: b
	b: a // b
	a: tmp
    ]
    a
]

lcm: func [a [integer!] b [integer!]] [
    a / (gcd a b) * b
]

solve: funct [] [
    total: 1
    for i 2 20 1 [
	total: lcm total i
    ]
    total
]

print solve
