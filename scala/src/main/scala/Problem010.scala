/*
 * Problem 10
 *
 * 08 February 2002
 *
 *
 * The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
 *
 * Find the sum of all the primes below two million.
 */
// 142913828922

import euler.AutoSieve

object Problem010 extends App {

  def answer: Long = {
    val s = new AutoSieve
    var p = 2
    var sum = 0L
    while (p < 2000000) {
      sum += p
      p = s.nextPrime(p)
    }
    sum
  }

  printf("%d\n", answer)
}
