/*
 * Problem 4
 *
 * 16 November 2001
 *
 *
 * A palindromic number reads the same both ways. The largest
 * palindrome made from the product of two 2-digit numbers is 9009
 * = 91 x 99.
 *
 * Find the largest palindrome made from the product of two 3-digit
 * numbers.
 * 906609
 */

object Problem004 extends App {

  def euler4(): Int = {
    var largest = -1

    for (a <- 100 to 999) {
      for (b <- a to 999) {
        val c = a * b
        if (c > largest && isPalindrome(c))
          largest = c
      }
    }

    largest
  }

  def isPalindrome(n: Int): Boolean = {
    n == reverseDigits(n)
  }

  def reverseDigits(n: Int): Int = {
    var result = 0
    var tmp = n
    while (tmp > 0) {
      result = result * 10 + tmp % 10
      tmp /= 10
    }
    result
  }

  printf("%d\n", euler4())

}
