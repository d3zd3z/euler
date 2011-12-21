// Prime number utilities

package euler

import "container/heap"
import "container/vector"

// A buildable prime-sieve, as described in
// http://programmingpraxis.com/2011/10/14/the-first-n-primes/
type node struct {
	next  int64
	steps vector.Vector // of int64
}

func (p *node) Less(y interface{}) bool {
	return p.next < y.(*node).next
}

type SieveHeap struct {
	prime int64
	nodes map[int64]*node
	heap  vector.Vector // of *node.
}

func (p *SieveHeap) addNode(next int64, step int64) {
	n, found := p.nodes[next]
	if !found {
		n = &node{next: next}
		p.nodes[next] = n
		heap.Push(&p.heap, n)
	}
	n.steps.Push(step)
}

// Update the lowest keyed node in the heap.
func (p *SieveHeap) updateFirst() {
	head := heap.Pop(&p.heap).(*node)
	p.nodes[head.next] = nil, false

	// Spread out the steps to all of the appropriate nodes.
	for _, stepI := range head.steps {
		step := stepI.(int64)
		p.addNode(head.next+step, step)
	}
}

func (p *SieveHeap) Next() (result int64) {
	if p.nodes == nil {
		p.nodes = make(map[int64]*node)
	}

	switch p.prime {
		// Manually feed the first three primes in.
	case 0:
		p.prime = 3
		return 2
	case 3:
		p.prime = 5
		p.addNode(9, 6)
		heap.Init(&p.heap)

		return 3

	default:
		for {
			peek := p.heap[0].(*node)
			cur := p.prime

			// If the 'next' divisor is greater than our current
			// number, this is prime.
			if cur < peek.next {
				result = cur
				p.prime = cur + 2
				p.addNode(cur*cur, cur+cur)

				return
			}

			// Otherwise, p.prime is composite, advance the next
			// values, and move on.
			p.updateFirst()
			p.prime += 2
		}
	}
	panic("unreachable")
}
