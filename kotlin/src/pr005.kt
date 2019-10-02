package org.davidb.euler

//////////////////////////////////////////////////////////////////////
// Problem 5
//
// 30 November 2001
//
// 2520 is the smallest number that can be divided by each of the
// numbers from 1 to 10 without any remainder.
//
// What is the smallest positive number that is evenly divisible by all
// of the numbers from 1 to 20?
//
// 232792560
//////////////////////////////////////////////////////////////////////

class Pr005: EulerSolution<Int>() {
    override val answer = 232792560
    override val num = 5

    private tailrec fun gcd(a: Int, b: Int): Int {
        if (b > 0) {
            return gcd(b, a % b)
        } else {
            return a
        }
    }

    private fun lcm(a: Int, b: Int): Int {
        return a * (b / gcd(a, b))
    }

    override fun solve() = (1 .. 20).reduce { a, b -> lcm(a, b) }
}
