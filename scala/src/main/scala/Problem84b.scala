// Problem 84, second implementation.
//
// Non-monte-carlo method.  Build a matrix of the probabilities and
// multiple.

object Problem84b extends App {

  val jail = 10
  val g2jail = 30

  val startingProbs = Array.fill(40)(1.0 / 40.0)

  // The overall probability matrix.  The first index is the starting
  // position, and the second array index is the probability of ending
  // up in that square.
  val probabilities = Array.fill(40)(Array.fill(40)(0.0))

  // Modular arithmetic, since it is so common.  Assumes the values
  // are at most 2*39, and we do addition.
  def modplus(item: Int): Int = {
    val len = startingProbs.length
    if (item >= len)
      item - len
    else if (item < 0)
      item + len
    else
      item
  }

  // Multiply a vector of position probabilities by a matrix to move
  // closer to the eigenvector.
  def multiply(vec: Array[Double], prob: Array[Array[Double]]): Array[Double] = {
    val tmp = new Array[Double](40)

    for (row <- 0 until 40) {
      val p = prob(row)
      var sum = 0.0
      for (col <- 0 until 40) {
        sum += vec(col) * probabilities(col)(row)
      }
      tmp(row) = sum
    }
    tmp
  }

  // Adjust the given probability row for a monopoly dice roll.
  // The rules are that play is as normal, but if a player rolls 3
  // doubles in a row, then they go directly to jail.  We can just say
  // that for the doubles values, 215/216 of the result goes into that
  // cell, and 1/216 increases the jail probability.
  def roll(row: Array[Double], piece: Int) {
    for (a <- 1 to 6) {
      for (b <- 1 to 6) {
        val dest = modplus(piece + a + b)
        if (a == b) {
          row(dest) += (1.0 / 36.0) * (215.0 / 216.0)
          row(jail) += (1.0 / 36.0) * (1.0 / 216.0)
        } else {
          row(dest) += 1.0 / 36.0
        }
      }
    }
  }

  def setupProbs() {
    for (i <- 0 until probabilities.length) {
      val p = probabilities(i)
      roll(p, i)

      // Landing on Go2Jail always ends up on jail.
      p(jail) += p(g2jail)
      p(g2jail) = 0

      // The community chest squares sometimes go to jail.
      def chest(pos: Int) {
        val tmp = p(pos)
        p(pos) = tmp * 14.0 / 16.0
        p(0) += tmp / 16.0
        p(10) += tmp / 16.0
      }
      chest(2)
      chest(17)
      chest(33)

      // The chance squares are more complicated, since they involve
      // various notions of what is next.  10/16 go to a different
      // square, and the remaining 6 stay.
      def chance(pos: Int, nextR: Int, nextU: Int, back3: Int) {
        val tmp = p(pos)
        p(pos) = tmp * 6.0 / 16.0
        p(0) += tmp / 16.0
        p(10) += tmp / 16.0
        p(11) += tmp / 16.0
        p(24) += tmp / 16.0
        p(39) += tmp / 16.0
        p(5) += tmp / 16.0
        p(nextR) += tmp * 2.0 / 16.0
        p(nextU) += tmp / 16.0
        p(back3) += tmp / 16.0
      }
      chance(7, 15, 12, 4)
      chance(22, 25, 28, 19)
      chance(36, 5, 12, 33)
    }
  }

  def showRow(row: Array[Double]) {
    var sum = 0.0
    for (i <- 0 until row.length) {
      printf("%3d -> %.8f (1/%.3f)\n", i, row(i), 1.0 / row(i))
      sum += row(i)
    }
    printf("sum = %.3f\n", sum)
  }

  def reduce(): Array[Double] = {
    var vec = startingProbs
    var count = 5000
    while (count > 0) {
      count -= 1
      vec = multiply(vec, probabilities)
    }
    vec
  }

  def scores(vec: Array[Double]) {
    val indices = Array.tabulate(vec.length)(i => i)
    util.Sorting.stableSort(indices, (a: Int, b: Int) => vec(a) > vec(b))

    for (c <- 0 until /* vec.length*/ 10) {
      val c2 = indices(c)
      printf("%02d %5.3f\n", c2, vec(c2) * 100.0)
    }
  }

  setupProbs()
  // showRow(probabilities(25))
  // printf("%s\n", probabilities(0).toList)
  // showRow(multiply(startingProbs, probabilities))
  // printf("%s\n", multiply(startingProbs, probabilities).toList)
  scores(reduce())
}
