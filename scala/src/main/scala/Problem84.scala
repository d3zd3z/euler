/**********************************************************************
 * Problem 84.
 *
 * http://projecteuler.net/index.php?section=problems&id=84
 */

// This works, but might not be the best way to do it.

import ec.util.MersenneTwister

object Problem84 extends App {

  val rand = new MersenneTwister

  class Square(val name: String, pos: Int) {
    def land: Int = pos
  }
  class GoSquare(name: String, pos: Int, dest: Int) extends Square(name, pos) {
    override def land: Int = dest
  }

  // To start with, just be random, rather than fixed with shuffling.
  class ChestSquare(name: String, pos: Int) extends Square(name, pos) {
    override def land: Int = {
      rand.nextInt(16) match {
        case 0 => 0
        case 1 => 10
        case _ => pos
      }
    }
  }

  class ChanceSquare(name: String, pos: Int, nextR: Int, nextU: Int, back3: Int) extends Square(name, pos) {
    override def land: Int = {
      rand.nextInt(16) match {
        case 1 => 0 // Go
        case 2 => 10 // JAIL
        case 3 => 11 // C1
        case 4 => 24 // E3
        case 5 => 39 // H2
        case 6 => 5 // R1
        case 7 => nextR
        case 8 => nextR
        case 9 => nextU
        case 10 => back3
        case _ => pos
      }
    }
  }

  class Play {
    val board = makeBoard()
    val counts = Array.fill(board.length)(0)

    private var dcount = 0

    def next(pos: Int): Int = {
      val a = rand.nextInt(4) + 1
      val b = rand.nextInt(4) + 1

      if (a == b) {
        dcount += 1
        if (dcount == 3) {
          dcount = 0
          return 10  // Go to jail.
        }
      } else {
        dcount = 0
      }

      val tmp = pos + a + b
      val npos = if (tmp < 40) tmp
        else tmp - 40

      board(npos).land
    }

    // Advance a piece across 'moves' moves, counting each position.
    def grind(moves: Int) {
      var pos = 0
      var count = 0
      while (count < moves) {
        pos = next(pos)
        counts(pos) += 1
        count += 1
      }
    }

    def scores() {
      val total = counts.sum

      val indices = Array.tabulate(board.length)(i => i)
      util.Sorting.stableSort(indices, (a: Int, b: Int) => counts(a) > counts(b))

      for (c <- 0 until counts.length) {
        val c2 = indices(c)
        printf("%02d %-4s %10d - %.6f\n", c2, board(c2).name, counts(c2),
          counts(c2).toDouble / total)
      }
    }
  }

  def makeBoard(): Array[Square] = {
    val board = List(
      new Square("Go", 0),
      new Square("A1", 1),
      new ChestSquare("CC1", 2),
      new Square("A2", 3),
      new Square("T1", 4),
      new Square("R1", 5),
      new Square("B1", 6),
      new ChanceSquare("CH1", 7, 15, 12, 4),
      new Square("B2", 8),
      new Square("B3", 9),
      new Square("JAIL", 10),
      new Square("C1", 11),
      new Square("U1", 12),
      new Square("C2", 13),
      new Square("C3", 14),
      new Square("R2", 15),
      new Square("D1", 16),
      new ChestSquare("CC2", 17),
      new Square("D2", 18),
      new Square("D3", 19),
      new Square("FP", 20),
      new Square("E1", 21),
      new ChanceSquare("CH2", 22, 25, 28, 19),
      new Square("E2", 23),
      new Square("E3", 24),
      new Square("R3", 25),
      new Square("F1", 26),
      new Square("F2", 27),
      new Square("U2", 28),
      new Square("F3", 29),
      new GoSquare("G2J", 30, 10),
      new Square("G1", 31),
      new Square("G2", 32),
      new ChestSquare("CC3", 33),
      new Square("G3", 34),
      new Square("R4", 35),
      new ChanceSquare("CH3", 36, 5, 12, 33),
      new Square("H1", 37),
      new Square("T2", 38),
      new Square("H2", 39))
    printf("board.length = %s\n", board.length)
    board.toArray
  }

  // Note that the "fast" version isn't actualy any faster on a modern
  // JVM.
  // val rand = new ec.util.MersenneTwisterFast
  // val rand = new java.util.Random

  val p = new Play
  p.grind(10000000)
  p.scores()
}
