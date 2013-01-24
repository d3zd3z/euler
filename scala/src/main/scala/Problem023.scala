/*
 * Problem 23
 *
 * 02 August 2002
 *
 *
 * A perfect number is a number for which the sum of its proper
 * divisors is exactly equal to the number. For example, the sum of
 * the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28,
 * which means that 28 is a perfect number.
 *
 * A number n is called deficient if the sum of its proper divisors
 * is less than n and it is called abundant if this sum exceeds n.
 *
 * As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16,
 * the smallest number that can be written as the sum of two
 * abundant numbers is 24. By mathematical analysis, it can be
 * shown that all integers greater than 28123 can be written as the
 * sum of two abundant numbers. However, this upper limit cannot be
 * reduced any further by analysis even though it is known that the
 * greatest number that cannot be expressed as the sum of two
 * abundant numbers is less than this limit.
 *
 * Find the sum of all the positive integers which cannot be
 * written as the sum of two abundant numbers.
 *
 * 4179871
 */

import euler.AutoSieve

object Problem023 extends App {

  class Euler23 {
    val sieve = new AutoSieve

    def isAbundant(n: Int): Boolean = {
      sieve.properDivisorSum(n) > n
    }

    def abundants(limit: Int): List[Int] = {
      (1 to limit).filter(isAbundant(_)).toList
    }

    def solve(): Int = {
      val limit = 28123
      var summable = Set[Int]()
      for (items <- abundants(limit).tails) items match {
        case Nil => ()
        case a::_ => {
          for (b <- items) {
            val ab = a + b
            if (ab <= limit)
              summable += ab
          }
        }
      }

      val allInts = Set() ++ (1 to limit)
      (allInts -- summable).foldLeft(0)(_+_)
    }

    // A more efficient solution.
    def solve2(): Int = {
      val limit = 28123
      val abundantList = abundants(limit)
      val abundantSet = Set() ++ abundantList
      def asSum(n: Int): Boolean = {
        abundantList.exists(x => abundantSet.contains(n-x))
      }
      (1 to limit).filter(!asSum(_)).foldLeft(0)(_+_)
    }
  }

  printf("%d\n", (new Euler23).solve2())
}
