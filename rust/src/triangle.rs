// Triangle utilities.

#[deriving(Clone, Show)]
pub struct Triple {
    a: uint,
    b: uint,
    c: uint
}

#[deriving(Clone, Show)]
struct Quad {
    p1: uint,
    p2: uint,
    q1: uint,
    q2: uint
}

static INITIAL_BOX: &'static Quad = &Quad { p1: 1, p2: 1, q1: 2, q2: 3 };

impl Triple {
    fn circumference(&self) -> uint {
        self.a + self.b + self.c
    }

    fn mult(&self, k: uint) -> Triple {
        Triple {
            a: self.a * k,
            b: self.b * k,
            c: self.c * k }
    }
}

impl Quad {
    fn children(&self) -> Vec<Quad> {
        let x = self.p2;
        let y = self.q2;
        vec![ Quad { p1: y-x, p2: x, q1:   y, q2: y*2 - x },
            Quad { p1:   x, p2: y, q1: x+y, q2: x*2 + y },
            Quad { p1:   y, p2: x, q1: y+x, q2: y*2 + x } ]
    }

    fn triangle(&self) -> Triple {
        Triple {
            a: self.q1 * self.p1 * 2,
            b: self.q2 * self.p2,
            c: self.p1 * self.q2 + self.p2 * self.q1 }
    }
}

// Generate all of the primitive Pythagorean triples with a
// circumference <= limit.  Calls 'f' for each possible triple.
fn generate_fibonacci_triples(limit: uint, f: |Triple, uint|) {
// fn generate_fibonacci_triples(limit: uint, f: &fn(Triple, uint)) {
    let mut work = vec![INITIAL_BOX.clone()];

    loop {
        match work.pop() {
            None => break,
            Some(abox) => {
                let triple = abox.triangle();
                let size = triple.circumference();
                if size <= limit {
                    f(triple, size);
                    work.extend(abox.children().into_iter());
                }
            }
        }
    }
}

// Generate all of the triples up to (and including) a given limit.
pub fn generate_triples(limit: uint, f: |Triple, uint|) {
    generate_fibonacci_triples(limit, |tri, circ| {
        let mut k = 1;
        loop {
            let kcirc = k * circ;
            if kcirc > limit { break; }
            f(tri.mult(k), kcirc);

            k += 1;
        }
    });
}

#[test]
fn test_children() {
    let next = INITIAL_BOX.children();
    println!("next: {}", next);
    let tris = next.iter().map(|x| {x.triangle()})
        .collect::<Vec<Triple>>();
    println!("tris: {}", tris);

    generate_triples(100, |tri, circ| {
        println!("  {:3} {}", circ, tri);
    });
}
