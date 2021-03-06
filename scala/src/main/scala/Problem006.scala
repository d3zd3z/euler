/*
 * Problem 6
 *
 * 14 December 2001
 *
 *
 * The sum of the squares of the first ten natural numbers is,
 *
 * 1^2 + 2^2 + ... + 10^2 = 385
 *
 * The square of the sum of the first ten natural numbers is,
 *
 * (1 + 2 + ... + 10)^2 = 55^2 = 3025
 *
 * Hence the difference between the sum of the squares of the first
 * ten natural numbers and the square of the sum is 3025 − 385 =
 * 2640.
 *
 * Find the difference between the sum of the squares of the first
 * one hundred natural numbers and the square of the sum.
 */
// 25164150

object Problem006 extends App {

  val limit = 100
  val sumSq = (1 to limit).foldLeft(0) { (a, b) => a + b*b }
  val sqSum = {
    val tmp = (1 to limit).foldLeft(0) { _ + _ }
    tmp * tmp
  }

  printf("%d\n", sqSum - sumSq)

}
