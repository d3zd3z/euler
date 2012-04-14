/*
 * By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we
 * can see that the 6th prime is 13.
 *
 * What is the 10 001st prime number?
 */

package euler

import scala.collection.mutable

object Problem7 {

  def main(args: Array[String]) {
    val sieve = new PrimeSieve
    for (i <- 1 to 10000) {
      sieve.next()
    }
    printf("%d\n", sieve.next())
  }
}

class PrimeSieve {

  class Node(val next: BigInt) {
    var steps = new mutable.Stack[BigInt]

    override def toString: String = {
      next.toString + ": " + steps.map{_.toString}.reduce { _ + ',' + _ }
    }
  }

  var prime = BigInt(2)
  var nodes = Map.empty[BigInt, Node]
  val heap = new mutable.PriorityQueue[Node]()(new math.Ordering[Node] {
    def compare(x: Node, y: Node): Int = {
      if (y.next == x.next)
	return 0
      if (y.next > x.next)
	return 1
      else
	return -1
    }
  })

  // Add a new step, possibly creating the node.  The node should not
  // already be present in the heap.
  def addNode(next: BigInt, step: BigInt) {
    val node = nodes.get(next) match {
      case None =>
	val node = new Node(next)
	nodes += (next -> node)
	heap += node
	node
      case Some(node) => node
    }
    node.steps.push(step)
  }

  // Update the lowest keyed node in the heap.
  def updateFirst() {
    val head = heap.dequeue()
    val next = head.next
    nodes -= next
    // Spread the steps to all appropriate nodes.
    for (step <- head.steps) {
      addNode(next + step, step)
    }
  }

  var debug = false

  def next(): BigInt = {
    if (debug) {
      printf("Next: h=%s\n", heap.toList.toString)
    }
    // printf("Next: h=%s\n", heap.toList.toString)
    if (prime == 2) {
      prime = 3
      return 2
    }
    if (prime == 3) {
      prime = 5
      addNode(9, 6)
      return 3
    }

    // Advance the prime number, skipping any composites.
    while (true) {
      val peek = heap.head
      val cur = prime

      // If the next divisor is greater than our current number, this
      // value is prime.
      if (cur < peek.next) {
	prime += 2
	addNode(cur * cur, cur + cur)
	return cur
      }

      // Otherwise, it is composite.
      updateFirst()
      prime += 2
    }
    sys.error("Not reached")
  }
}
