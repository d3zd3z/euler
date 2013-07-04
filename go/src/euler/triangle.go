package euler

// Triangle manipulations.
type Box struct {
	P1, P2, Q1, Q2 int
}

type Triple struct {
	A, B, C int
}

type TripleInfo struct {
	Tri Triple
	Circumference int
}

var initialBox = Box{P1: 1, P2: 1, Q1: 2, Q2: 3}

// Compute the primitive triples.
func FibonacciTriples(limit int) (result []TripleInfo) {
	result = make([]TripleInfo, 0)

	work := make([]Box, 1)
	work[0] = initialBox

	for len(work) > 0 {
		box := work[0]
		work = work[1:]

		tri := makeTriple(box)
		circ := ComputeCircumference(tri)
		if circ <= limit {
			work = append(work, children(box)...)
			result = append(result, TripleInfo{Tri: tri, Circumference: circ})
		}
	}
	return
}

func AllTriples(limit int) (result []TripleInfo) {
	base := FibonacciTriples(limit)
	result = make([]TripleInfo, 0)

	for _, t := range base {
		for k := 1; true; k++ {
			t2 := multipleTriple(t.Tri, k)
			c2 := t.Circumference * k
			if c2 > limit {
				break
			}

			result = append(result, TripleInfo{Tri: t2, Circumference: c2})
		}
	}
	return
}

func children(in Box) (result []Box) {
	result = make([]Box, 3)

	x := in.P2
	y := in.Q2

	result[0] = Box{P1: y - x, P2: x, Q1: y, Q2: y * 2 - x}
	result[1] = Box{P1: x, P2: y, Q1: x + y, Q2: x * 2 + y}
	result[2] = Box{P1: y, P2: x, Q1: x + y, Q2: y * 2 + x}
	return
}

func ComputeCircumference(tri Triple) int {
	return tri.A + tri.B + tri.C
}

func makeTriple(in Box) (result Triple) {
	result.A = in.Q1 * in.P1 * 2
	result.B = in.Q2 * in.P2
	result.C = in.P1 * in.Q2 + in.P2 * in.Q1
	return
}

func multipleTriple(in Triple, k int) (result Triple) {
	result.A = in.A * k
	result.B = in.B * k
	result.C = in.C * k
	return
}
