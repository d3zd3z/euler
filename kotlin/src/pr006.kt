package org.davidb.euler

// Problem 6
//
// 14 December 2001
//
// The sum of the squares of the first ten natural numbers is,
//
// 1^2 + 2^2 + ... + 10^2 = 385
//
// The square of the sum of the first ten natural numbers is,
//
// (1 + 2 + ... + 10)^2 = 55^2 = 3025
//
// Hence the difference between the sum of the squares of the first ten
// natural numbers and the square of the sum is 3025 − 385 = 2640.
//
// Find the difference between the sum of the squares of the first one
// hundred natural numbers and the square of the sum.
// 25164150

// define_problem!(pr006, 6, 25164150);

class Pr006: EulerSolution<Int>() {
    override val answer = 25164150
    override val num = 6

    override fun solve(): Int {
        val sum_sq = (1 .. 100).map { it * it }.sum()
        val tmp = (1 .. 100).sum()
        val sq_sum = tmp * tmp

        return sq_sum - sum_sq
    }
}
