// Prime number utilities

package euler

import "container/heap"

// A buildable prime-sieve, as described in
// http://programmingpraxis.com/2011/10/14/the-first-n-primes/
type node struct {
	next  int64
	steps []int64
}

func (p *node) Less(y interface{}) bool {
	return p.next < y.(*node).next
}

type SieveHeap struct {
	prime int64
	nodes map[int64]*node
	heap  nodeHeap
}

func (p *SieveHeap) addNode(next int64, step int64) {
	n, found := p.nodes[next]
	if !found {
		n = &node{next: next}
		p.nodes[next] = n
		heap.Push(&p.heap, n)
	}
	n.steps = append(n.steps, step)
}

// Update the lowest keyed node in the heap.
func (p *SieveHeap) updateFirst() {
	head := heap.Pop(&p.heap).(*node)
	delete(p.nodes, head.next)

	// Spread out the steps to all of the appropriate nodes.
	for _, step := range head.steps {
		p.addNode(head.next+step, step)
	}
}

type nodeHeap []*node

func (p *nodeHeap) Len() int {
	return len(*p)
}

func (p *nodeHeap) Less(i, j int) bool {
	return (*p)[i].next < (*p)[j].next
}

func (p *nodeHeap) Pop() (result interface{}) {
	result, *p = (*p)[len(*p)-1], (*p)[:len(*p)-1]
	return
}

func (p *nodeHeap) Push(x interface{}) {
	*p = append(*p, x.(*node))
}

func (p *nodeHeap) Swap(i, j int) {
	(*p)[i], (*p)[j] = (*p)[j], (*p)[i]
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
			peek := p.heap[0]
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
