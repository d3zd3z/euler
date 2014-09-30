/*
 * Problem 21
 *
 * 05 July 2002
 *
 *
 * Let d(n) be defined as the sum of proper divisors of n (numbers
 * less than n which divide evenly into n).
 * If d(a) = b and d(b) = a, where a ≠ b, then a and b are an
 * amicable pair and each of a and b are called amicable numbers.
 *
 * For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11,
 * 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper
 * divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.
 *
 * Evaluate the sum of all the amicable numbers under 10000.
 *
 * 31626
 */

object Problem021 extends App {

  // Build an array of divisor counts up to (not including 'n').
  class DivisorTable(var limit: Int) {
    val divisors: Array[Int] = {
      val buf = Array.fill[Int](limit)(0)

      for (a <- 1 until limit) {
        for (b <- a+a until limit by a) {
          buf(b) += a
        }
      }

      buf
    }

    def isAmicable(a: Int): Boolean = {
      if (a >= limit)
        return false
      val b = divisors(a)
      if (b < 1 || b >= limit || a == b)
        return false
      val c = divisors(b)
      a == c
    }
  }

  def solve() {
    var total = 0
    val dt = new DivisorTable(10000)
    for (i <- 1 until dt.limit) {
      if (dt.isAmicable(i)) {
        total += i
      }
    }
    printf("%d\n", total)
  }

  solve()
}
