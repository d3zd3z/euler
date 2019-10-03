package org.davidb.euler

//////////////////////////////////////////////////////////////////////
// Problem 4
//
// 16 November 2001
//
// A palindromic number reads the same both ways. The largest
// palindrome made from the product of two 2-digit numbers is 9009 = 91
// × 99.
//
// Find the largest palindrome made from the product of two 3-digit
// numbers.
//
// 906609
//////////////////////////////////////////////////////////////////////

class Pr004: EulerSolution<Int>() {
    override val answer = 906609
    override val num = 4

    // Reverse the digits of a positive number
    private fun reverseDigits(num: Int, base: Int = 10): Int {
        var work = num
        var result = 0
        while (work > 0) {
            result = result * base + work % base
            work /= base
        }
        return result
    }

    private fun isPalindrome(num: Int, base: Int = 10): Boolean {
        return num == reverseDigits(num, base)
    }

    override fun solve() = (100 .. 999)
        .asSequence()
        .flatMap { a -> (a .. 999).asSequence().map { b -> a * b } }
        .filter { isPalindrome(it) }
        .max()!!
}
