/*
 * Problem 14
 *
 * 05 April 2002
 *
 * The following iterative sequence is defined for the set of
 * positive integers:
 *
 * n → n/2 (n is even)
 * n → 3n + 1 (n is odd)
 *
 * Using the rule above and starting with 13, we generate the
 * following sequence:
 *
 * 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
 *
 * It can be seen that this sequence (starting at 13 and finishing
 * at 1) contains 10 terms. Although it has not been proved yet
 * (Collatz Problem), it is thought that all starting numbers
 * finish at 1.
 *
 * Which starting number, under one million, produces the longest
 * chain?
 *
 * NOTE: Once the chain starts the terms are allowed to go above
 * one million.
 *
 * 837799
 */

// Note that the intermediate value is larger than 31-bits.

import scala.annotation.tailrec

object Problem014 extends App {

  // Simple tail recursive non-cached version.
  def chainLength(n: Long): Int = {
    @tailrec
    def loop(length: Int, n: Long): Int = {
      if (n == 1) length
      else if ((n & 1) == 0)
        loop(length + 1, n / 2)
      else
        loop(length + 1, n * 3 + 1)
    }
    loop(1, n)
  }

  // Cached version.  Not tail recursive, though.  It's also very, very slow.
  class Cached(len: Int) {
    val cache = Array.fill[Int](len)(0)

    def chainLen(n: Long): Int = {
      if (n < len.toLong) {
        val tmp = cache(n.toInt)
        if (tmp == 0) {
          val result = chainLen2(n)
          cache(tmp) = result
          result
        } else
          tmp
      } else {
        chainLen2(n)
      }
    }

    private def chainLen2(n: Long): Int = {
      if (n == 1) 1
      else if ((n & 1) == 0)
        1 + chainLen(n / 2)
      else
        1 + chainLen(n * 3 + 1)
    }
  }

  def solve(chainLen: Long => Int): Long = {
    @tailrec
    def loop(longest: Int, longestN: Long, n: Long): Long = {
      if (n >= 1000000)
        return longestN
      val thisLen = chainLen(n)
      if (thisLen > longest)
        loop(thisLen, n, n+1)
      else
        loop(longest, longestN, n+1)
    }
    loop(0, 0, 1)
  }

  printf("%d\n", solve(chainLength(_)))
  // printf("%d\n", solve(new Cached(1000).chainLen(_)))
}
