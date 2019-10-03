// Problem 10
//
// 08 February 2002
//
// The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
//
// Find the sum of all the primes below two million.
//
// 142913828922

package org.davidb.euler

class Pr010 : EulerSolution<Long>() {
    override val answer = 142913828922L
    override val num = 10

    override fun solve() = Sieve().iterator().asSequence()
        .takeWhile { it < 2000000 }
        .map { it.toLong() }
        .sum()
}
