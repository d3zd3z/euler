"""Triangle utilities"""

from collections import namedtuple

class Triple(namedtuple('Triple', ['a', 'b', 'c'])):

    def circumference(self):
        return self.a + self.b + self.c

    def mult(self, k):
        return Triple(self.a * k, self.b * k, self.c * k)

class Box(namedtuple('Box', ['p1', 'p2', 'q1', 'q2'])):

    def children(self):
        x = self.p2
        y = self.q2
        return [Box(y-x, x,   y, y*2 - x),
                Box(  x, y, x+y, x*2 + y),
                Box(  y, x, x+y, y*2 + x) ]

    def triangle(self):

        return Triple(self.q1 * self.p1 * 2,
                self.q2 * self.p2,
                self.p1 * self.q2 + self.p2 * self.q1)

initial_box = Box(1, 1, 2, 3)

def fibonacci_triples(limit):
    """Generate all of the fibonacci triples with a circumference less
    than limit.  Yields (triple, circumference) for each triple."""
    work = [initial_box]

    while len(work) > 0:
        abox = work.pop()
        triple = abox.triangle()
        size = triple.circumference()
        if size <= limit:
            yield (triple, size)
            work.extend(abox.children())

def triples(limit):
    """Generate all triples up to (and including) a given limit.
    Returns (triple, circumference) for each."""
    for tri, circ in fibonacci_triples(limit):
        k = 1
        while True:
            kcirc = k * circ
            if kcirc > limit: break
            yield (tri.mult(k), kcirc)
            k += 1

if __name__ == '__main__':
    for t in triples(100):
        print(t)
