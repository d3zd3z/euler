/**********************************************************************
 * Problem 81
 *
 * 22 October 2004
 *
 * In the 5 by 5 matrix below, the minimal path sum from the top left
 * to the bottom right, by only moving to the right and down, is
 * indicated in bold red and is equal to 2427.
 *
 *     131 673 234 103 18
 *     201 96  342 965 150
 * [b] 630 803 746 422 111 [b]
 *     537 699 497 121 956
 *     805 732 524 37  331
 *
 * Find the minimal path sum, in matrix.txt (right click and 'Save Link
 * /Target As...'), a 31K text file containing a 80 by 80 matrix, from
 * the top left to the bottom right by only moving right and down.
 **********************************************************************/

import scala.collection.mutable
import scala.annotation.tailrec

object Problem081 {

  // Graph representation.  The vertices are numbered starting from 0
  // until vertexCount-1.
  abstract class Graph {
    protected def width: Int
    protected def height: Int
    protected def values: Array[Int]

    def vertexCount = 1 + width*height

    case class Edge(to: Int) {
      def cost: Int = values(to - 1)
    }

    // Get the list of edges from the given node.
    def edge(node: Int): List[Edge] = {
      if (node == 0)
        // Starting node (faked).
        rootEdges()
      else {
        val n2 = node - 1
        val y = n2 / width
        val x = n2 % width
        nodeEdges(x, y)
      }
    }

    protected def rootEdges(): List[Edge]
    protected def nodeEdges(x: Int, y: Int): List[Edge]

    protected def indexOf(x: Int, y: Int): Int = {
      1 + y*width + x
    }

    // Get all of the edges.
    def edges(): Array[Edge] =
      (for (n <- 0 until vertexCount; edge <- edge(n))
        yield edge).toArray
  }

  // Problem 81 connects each node to one to the right and one down.
  class Graph81(protected val width: Int, protected val height: Int, protected val values: Array[Int]) extends Graph {
    protected def rootEdges(): List[Edge] = List(Edge(1))

    protected def nodeEdges(x: Int, y: Int): List[Edge] = {
      val result = new mutable.ListBuffer[Edge]
      if (y < height-1)
        result += Edge(indexOf(x, y+1))
      if (x < width-1)
        result += Edge(indexOf(x+1, y))
      result.toList
    }
  }

  // Problem 82 connects each node to up, down, and right.  The root
  // points to all of the left column, and any of the right column are
  // terminating nodes.
  class Graph82(protected val width: Int, protected val height: Int, protected val values: Array[Int]) extends Graph {
    protected def rootEdges(): List[Edge] = ((0 until height) map (y => Edge(indexOf(0, y)))).toList

    protected def nodeEdges(x: Int, y: Int): List[Edge] = {
      if (x == width-1)
        return List()

      val result = new mutable.ListBuffer[Edge]
      if (y > 0)
        result += Edge(indexOf(x, y-1))
      if (y < height-1)
        result += Edge(indexOf(x, y+1))
      if (x < width-1)
        result += Edge(indexOf(x+1, y))
      result.toList
    }
  }

  // Problem 83 connects each node to up, down, left, and right.  The
  // root is the upper left.  The lower-left node doesn't point
  // anywhere (special case) as the exit.
  class Graph83(protected val width: Int, protected val height: Int, protected val values: Array[Int]) extends Graph {
    protected def rootEdges(): List[Edge] = List(Edge(indexOf(0, 0)))

    protected def nodeEdges(x: Int, y: Int): List[Edge] = {
      if (x == width-1 && y == height-1)
        return List()

      val result = new mutable.ListBuffer[Edge]
      if (y > 0)
        result += Edge(indexOf(x, y-1))
      if (y < height-1)
        result += Edge(indexOf(x, y+1))
      if (x > 0)
        result += Edge(indexOf(x-1, y))
      if (x < width-1)
        result += Edge(indexOf(x+1, y))
      result.toList
    }
  }

  class Dijkstra(val graph: Graph) {
    class Node(val index: Int) {
      var sum = Integer.MAX_VALUE
      val visited = false
    }

    val nodes = ((0 until graph.vertexCount) map (new Node(_))).toArray
    var unseen = nodes.toList
    unseen.head.sum = 0

    var seen = Set.empty[Int]

    lazy val minimal = walk()

    @tailrec
    private def walk(): Int = {
      // Take the smallest node.
      unseen.sortBy(_.sum) match {
        case List() => sys.error("No nodes: graph doesn't have an end.")
        case a :: rest =>
          val nodeSum = a.sum
          unseen = rest
          val edges = graph.edge(a.index)
          if (edges == List())
            nodeSum
          else {
            for (j <- edges) {
              if (!(seen contains j.to)) {
                var newSum = nodeSum + j.cost
                if (newSum < nodes(j.to).sum)
                  nodes(j.to).sum = newSum
              }
            }

            seen += a.index
            walk()
          }
      }
    }
  }

  object Graph {
    private val classes = Map(
      ("Graph81" -> ((width: Int, height: Int, values: Array[Int]) => new Graph81(width, height, values))),
      ("Graph82" -> ((width: Int, height: Int, values: Array[Int]) => new Graph82(width, height, values))),
      ("Graph83" -> ((width: Int, height: Int, values: Array[Int]) => new Graph83(width, height, values))))

    def apply(name: String, url: java.net.URL): Graph = {
      val builder = classes get name match {
        case None => sys.error("Invalid class name")
        case Some(b) => b
      }
      val lines = io.Source.fromURL(url).getLines
      val values = (lines map (decodeLine _)).toList
      assert(sameLength(values))
      val height = values.length
      val width = values.head.length

      // printf("len = %d\n", values.length)
      // printf("values = %s\n", values.flatten)
      builder(width, height, values.flatten.toArray)
    }

    @tailrec
    def sameLength(node: List[Seq[_]]): Boolean = node match {
      case List() => true
      case List(_) => true
      case a :: b :: rest =>
        a.length == b.length && sameLength(b :: rest)
    }

    private def decodeLine(line: String): List[Int] = {
      val parts = (line split ",").toList
      parts map (x => java.lang.Integer.parseInt(x))
    }

  }

  def solve(name: String) {
    val graph = Graph(name, this.getClass.getResource("matrix.txt"))
    val dij = new Dijkstra(graph)
    printf("%s = %d\n", name, dij.minimal)
  }

  def main(args: Array[String]) {
    solve("Graph81")
    solve("Graph82")
    solve("Graph83")
  }
}
