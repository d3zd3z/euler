/*
 * Problem 9
 *
 * 25 January 2002
 *
 *
 * A Pythagorean triplet is a set of three natural numbers, a < b <
 * c, for which,
 *
 * a^2 + b^2 = c^2
 *
 * For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
 *
 * There exists exactly one Pythagorean triplet for which a + b + c
 * = 1000.
 * Find the product abc.
 */
// 31875000

object Problem009 extends App {

  def answer: Int = {
    for (a <- 1 to 999) {
      for (b <- a to 999) {
        val c = 1000 - a - b
        if (c > b && a*a + b*b == c*c) {
          return a*b*c
        }
      }
    }
    sys.error("No answer found")
  }

  printf("%d\n", answer)

}
