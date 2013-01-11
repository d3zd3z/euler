/* Prime number sieve. */

package euler

import scala.collection.mutable.BitSet
import scala.collection.mutable.ListBuffer

// An integer based sieve.  Simple imperative approach.
class Sieve(val limit: Int) {
  val composite = new BitSet(limit)
  composite += 0
  composite += 1

  def init() {
    var p = 2
    while (p < limit) {
      var n = p+p
      while (n < limit) {
        composite += n
        n += p
      }

      p = if (p == 2) 3 else p+2
    }
  }
  init()

  def isPrime(num: Int): Boolean = !composite.contains(num)
}

case class Factor(prime: Int, power: Int)

class AutoSieve {

  def isPrime(num: Int): Boolean = {
    if (num >= sieve.limit) {
      sieve = new Sieve(findLimit(num))
    }
    sieve.isPrime(num)
  }

  def nextPrime(num: Int): Int = {
    var p = if (num == 2) 3 else num+2
    while (!isPrime(p))
      p += 2
    p
  }

  def factorize(number: Int): List[Factor] = {
    var num = number
    val result = new ListBuffer[Factor]

    var p = 2
    var count = 0
    while (num > 1) {
      if (num % p == 0) {
        num /= p
        count += 1
      } else {
        if (count > 0) {
          result += Factor(p, count)
          count = 0
        }
        p = nextPrime(p)
      }
    }
    if (count > 0) {
      result += Factor(p, count)
    }

    result.result
  }

  def divisors(number: Int) = spread(factorize(number)).sorted

  private def spread(factors: List[Factor]): List[Int] = factors match {
    case Nil => List(1)
    case x::others => {
      val rest = spread(others)

      var power = 1
      val result = new ListBuffer[Int]
      for (i <- 0 to x.power) {
        for (elt <- rest)
          result += elt * power

        if (i < power)
          power *= x.prime
      }
      result.result
    }
  }

  def divisorCount(number: Int): Int = {
    val facts = factorize(number)
    facts.foldLeft(1)((a, b) => a * (b.power + 1))
  }

  private var sieve = new Sieve(1024)
  private def findLimit(num: Int): Int = {
    var size = 1024
    while (size < num)
      size *= 8
    size
  }
}
