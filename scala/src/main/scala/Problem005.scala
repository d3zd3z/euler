/*
 * Problem 5
 *
 * 30 November 2001
 *
 *
 * 2520 is the smallest number that can be divided by each of the
 * numbers from 1 to 10 without any remainder.
 *
 * What is the smallest positive number that is evenly divisible by
 * all of the numbers from 1 to 20?
 */
// 232792560

import scala.annotation.tailrec

object Problem005 extends App {

  def lcm(a: BigInt, b: BigInt): BigInt = {
    (a / gcd(a, b)) * b
  }

  @tailrec
  def gcd(a: BigInt, b: BigInt): BigInt = {
    if (b == 0)
      a
    else
      gcd(b, a % b)
  }

  val result = (2 to 20).map(BigInt(_)).foldLeft(BigInt(1))(lcm _)

  printf("%s\n", result)

}
