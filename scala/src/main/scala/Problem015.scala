/*
 * Problem 15
 *
 * 19 April 2002
 *
 *
 * Starting in the top left corner of a 2x2 grid, there are 6
 * routes (without backtracking) to the bottom right corner.
 *
 * [p_015]
 *
 * How many routes are there through a 20x20 grid?
 *
 * 137846528820
 */

import scala.annotation.tailrec

object Problem015 extends App {
  def base(n: Int): List[Long] = List.fill(n+1)(1)

  def bump(elts: List[Long]): List[Long] = elts match {
    case a::b::as => a :: bump(a+b :: as)
    case x => x
  }

  // Apply fn to item 'count' times, returning the final result.
  // Equivalent to fn(fn(fn(...fn(item)))).
  @tailrec
  def repeat[T](count: Int, item: T, fn: T => T): T = {
    if (count == 0)
      item
    else
      repeat(count-1, fn(item), fn)
  }

  def solve(n: Int): Long = {
    repeat(n, base(n), bump _).last
  }

  printf("%d\n", solve(20))
}
