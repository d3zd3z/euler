/*
 * Problem 16
 *
 * 03 May 2002
 *
 *
 * 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 =
 * 26.
 *
 * What is the sum of the digits of the number 2^1000?
 *
 * 1366
 */

import scala.annotation.tailrec
import scala.math.BigInt

object Problem016 extends App {

  def digitSum(num: BigInt): Int = {
    @tailrec
    def loop(num: BigInt, result: Int): Int = {
      if (num == 0)
        result
      else {
        val (n, m) = num /% 10
        loop(n, result + m.intValue)
      }
    }
    loop(num, 0)
  }

  printf("%d\n", digitSum(BigInt(2).pow(1000)))
}
