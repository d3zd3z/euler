/**********************************************************************/
// Problem 95
//
// 13 May 2005
//
//
// The proper divisors of a number are all the divisors excluding
// the number itself. For example, the proper divisors of 28 are 1,
// 2, 4, 7, and 14. As the sum of these divisors is equal to 28, we
// call it a perfect number.
//
// Interestingly the sum of the proper divisors of 220 is 284 and
// the sum of the proper divisors of 284 is 220, forming a chain of
// two numbers. For this reason, 220 and 284 are called an amicable
// pair.
//
// Perhaps less well known are longer chains. For example, starting
// with 12496, we form a chain of five numbers:
//
// 12496 → 14288 → 15472 → 14536 → 14264 (→ 12496 → ...)
//
// Since this chain returns to its starting point, it is called an
// amicable chain.
//
// Find the smallest member of the longest amicable chain with no
// element exceeding one million.
/**********************************************************************/

import annotation.tailrec

object Problem95 {
  def main(args: Array[String]) {
    val solver = new Problem95(1000000)
    printf("Answer: %d\n", solver.answer)
  }
}

class Problem95(limit: Int) {
  val divisors = Array.fill(limit)(0)

  // Seen is filled with the starting number we used to scan it.
  val seen = Array.fill(limit)(0)

  var longest = -1
  var answer = 0

  // Set the divisor counts.
  for (base <- 1 until limit) {
    for (index <- (2*base) until limit by base) {
      divisors(index) += base
    }
  }

  // Count up the chains.
  for (i <- 1 until limit) {
    if (seen(i) == 0) {
      mark(i, i)
    }
  }

  // Mark, starting at pos.  If we find a cycle, try using it.
  @tailrec
  private def mark(start: Int, pos: Int) {
    if (pos < limit && pos > 0) {
      if (seen(pos) == start) {
        cycleLen(pos)
      } else if (seen(pos) == 0) {
        seen(pos) = start
        mark(start, divisors(pos))
      } else {
        // Otherwise, we've entered this cycle another way, so skip
        // it.
      }
    }
  }

  // Count the length of the cycle at 'pos', and update the longest if
  // it is longer.
  private def cycleLen(pos: Int) {
    // printf("cycleLen: %d\n", pos)
    var len = 1
    var smallest = pos
    var tmp = divisors(pos)
    while (tmp != pos) {
      if (tmp < smallest)
        smallest = tmp
      len += 1
      tmp = divisors(tmp)
    }

    if (len > longest) {
      longest = len
      // printf("New longest: %d, %d\n", len, smallest)
      answer = smallest
    }
  }
}
