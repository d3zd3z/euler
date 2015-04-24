#! /usr/bin/env r3

REBOL [
    Title: "Problem 3"

    Description: {
         Problem 3

         02 November 2001


         The prime factors of 13195 are 5, 7, 13 and 29.

         What is the largest prime factor of the number 600851475143 ?

    }

    Solution: 6857
]

; Note that this probably doesn't work on 32-bit R3 installs.

solve: funct [] [
    n: 600851475143
    p: 3
    while [n > 1] [
        either n // p = 0 [
            n: n / p
        ] [
            p: p + 2
        ]
    ]

    p
]

print solve
