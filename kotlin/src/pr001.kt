package org.davidb.euler

//////////////////////////////////////////////////////////////////////
// Problem 1
//
// 05 October 2001
//
// If we list all the natural numbers below 10 that are multiples of 3
// or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
//
// Find the sum of all the multiples of 3 or 5 below 1000.
//
// 233168
//////////////////////////////////////////////////////////////////////

class Pr001: EulerSolution<Int>() {
    override fun solve(): Int {
        // var total = 0
        // for (i in 1..999) {
        //     if (i % 3 == 0 || i % 5 == 0) {
        //         total += i
        //     }
        // }
        return (1..999).filter { it % 3 == 0 || it % 5 == 0 }.sum()
    }

    override val answer = 233168
    override val num = 1
}
