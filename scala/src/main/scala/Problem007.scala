/*
 * Problem 7
 *
 * 28 December 2001
 *
 *
 * By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13,
 * we can see that the 6th prime is 13.
 *
 * What is the 10 001st prime number?
 */
// 104743

import euler.AutoSieve

object Problem007 extends App {

  val answer = {
    val s = new AutoSieve
    var count = 1
    var prime = 2
    while (count < 10001) {
      prime = s.nextPrime(prime)
      count += 1
    }
    prime
  }

  printf("%d\n", answer)

}
