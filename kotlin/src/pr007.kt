// Problem 7
//
// 28 December 2001
//
// By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
// that the 6th prime is 13.
//
// What is the 10 001st prime number?
//
// 104743

package org.davidb.euler

class Pr007: EulerSolution<Int>() {
    override val answer = 104743
    override val num = 7

    override fun solve() = Sieve().iterator().asSequence().drop(10000).first()
}
