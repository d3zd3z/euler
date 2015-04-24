#! /usr/bin/env r3

REBOL [
    Title: "Problem 4"

    Description: {
         Problem 4

         16 November 2001


         A palindromic number reads the same both ways. The largest palindrome made
         from the product of two 2-digit numbers is 9009 = 91 x 99.

         Find the largest palindrome made from the product of two 3-digit numbers.

    }

    Solution: x
]

rev-digits: funct [num [integer!]] [
    result: 0
    while [num <> 0] [
        result: result * 10 + (num // 10)
        num: to-integer num / 10
    ]
    result
]

palindrome?: funct [num [integer!]] [
    (rev-digits num) = num
]

solve: funct [] [
    largest: 0
    for a 100 999 1 [
        for b 100 999 1 [
            c: a * b
            if (palindrome? c) and (c > largest) [
                largest: c
            ]
        ]
    ]
    largest
]

print solve
