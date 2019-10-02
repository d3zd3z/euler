package org.davidb.euler

//////////////////////////////////////////////////////////////////////
// Problem 3
//
// 02 November 2001
//
// The prime factors of 13195 are 5, 7, 13 and 29.
//
// What is the largest prime factor of the number 600851475143 ?
//
// 6857
//////////////////////////////////////////////////////////////////////

class Pr003: EulerSolution<Int>() {
    override val answer = 6857
    override val num = 3

    override fun solve(): Int {
        // A fairly simple approach.
        var num = 600851475143L
        var factor = 1

        while (num > 1) {
            factor += 2

            while (num % factor == 0L) {
                num /= factor
            }
        }
        return factor
    }
}
