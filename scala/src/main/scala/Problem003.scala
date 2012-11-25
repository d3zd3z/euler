/*
 * Problem 3
 *
 * 02 November 2001
 *
 *
 * The prime factors of 13195 are 5, 7, 13 and 29.
 *
 * What is the largest prime factor of the number 600851475143 ?
 * 6857
 */

object Problem003 extends App {

  def euler3(): Long = {
    var num = 600851475143L
    var factor = 2L

    while (num > 1) {
      while (num % factor == 0) {
        num /= factor
      }

      if (factor == 2)
        factor = 3
      else
        factor += 2
    }

    factor
  }
  printf("%d\n", euler3())

}
