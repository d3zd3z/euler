/*
 * Problem 20
 *
 * 21 June 2002
 *
 *
 * n! means n × (n − 1) × ... × 3 × 2 × 1
 *
 * For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
 * and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8
 * + 0 + 0 = 27.
 *
 * Find the sum of the digits in the number 100!
 *
 * 648
 */

object Problem020 extends App {

  def digitsum(n: BigInt): Int = {
    var res = 0
    var tmp = n
    while (tmp > 0) {
      res += (tmp % 10).toInt
      tmp /= 10
    }

    res
  }

  def factorial(n: Int): BigInt = {
    var result = BigInt(1)
    for (i <- 2 to n) {
      result *= i
    }
    result
  }

  def solve() {
    printf("%d\n", digitsum(factorial(100)))
  }

  solve()
}
