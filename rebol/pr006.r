#! /usr/bin/env r3

REBOL [
    Title: "Problem 6"

    Description: {
         Problem 6

         14 December 2001

         The sum of the squares of the first ten natural numbers is,

         1^2 + 2^2 + ... + 10^2 = 385

         The square of the sum of the first ten natural numbers is,

         (1 + 2 + ... + 10)^2 = 55^2 = 3025

         Hence the difference between the sum of the squares of the first ten
         natural numbers and the square of the sum is 3025 − 385 = 2640.

         Find the difference between the sum of the squares of the first one
         hundred natural numbers and the square of the sum.

    }

    Solution: 25164150
]

solve: funct [] [
    sum-sq: 0
    sum: 0
    repeat i 100 [
	sum: sum + i
	sum-sq: sum-sq + (i * i)
    ]
    sum * sum - sum-sq
]

print solve
