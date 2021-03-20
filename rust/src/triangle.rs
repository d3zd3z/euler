// Triangle utilities.

#[derive(Clone, Debug)]
pub struct Triple {
    a: u32,
    b: u32,
    c: u32
}

#[derive(Clone, Debug)]
struct Quad {
    p1: u32,
    p2: u32,
    q1: u32,
    q2: u32
}

static INITIAL_BOX: &'static Quad = &Quad { p1: 1, p2: 1, q1: 2, q2: 3 };

impl Triple {
    fn circumference(&self) -> u32 {
        self.a + self.b + self.c
    }

    fn mult(&self, k: u32) -> Triple {
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

pub struct IterItem {
    pub tri: Triple,
    pub circ: u32,
}

pub struct FibonacciIter {
    work: Vec<Quad>,
    limit: u32,
}

impl FibonacciIter {
    pub fn new(limit: u32) -> FibonacciIter {
        FibonacciIter {
            work: vec![INITIAL_BOX.clone()],
            limit,
        }
    }
}

impl Iterator for FibonacciIter {
    type Item = IterItem;

    fn next(&mut self) -> Option<IterItem> {
        match self.work.pop() {
            None => None,
            Some(abox) => {
                let tri = abox.triangle();
                let size = tri.circumference();
                if size <= self.limit {
                    self.work.extend(abox.children().into_iter());
                    Some(IterItem {
                        tri,
                        circ: size,
                    })
                } else {
                    self.next()
                }
            },
        }
    }
}

pub struct Iter {
    root: FibonacciIter,
    cur: Option<IterItem>,
    k: u32,
    limit: u32,
}

impl Iter {
    pub fn new(limit: u32) -> Iter {
        Iter {
            root: FibonacciIter::new(limit),
            cur: None,
            k: 0,
            limit,
        }
    }
}

impl Iterator for Iter {
    type Item = IterItem;

    fn next(&mut self) -> Option<IterItem> {
        loop {
            // Make sure we have a root to look at.
            if self.cur.is_none() {
                self.cur = self.root.next();
                self.k = 1;
            }

            // Handle the case where we still have some work to do.  Returns a
            // result if that is known.
            match self.cur {
                None => return None,
                Some(IterItem { ref tri, circ }) => {
                    let kcirc = self.k * circ;
                    if kcirc <= self.limit {
                        let k1 = self.k;
                        self.k += 1;
                        return Some(IterItem {
                            tri: tri.mult(k1),
                            circ: kcirc,
                        })
                    }
                },
            }

            // Otherwise, we've exhaused this particular root, clear it, and
            // move on to the next one.
            self.cur = None;
        }
    }
}

#[test]
fn test_children() {
    let next = INITIAL_BOX.children();
    println!("next: {:?}", next);
    let tris = next.iter().map(|x| {x.triangle()})
        .collect::<Vec<Triple>>();
    println!("tris: {:?}", tris);

    /*
    generate_triples(100, |tri, circ| {
        println!("  {:3} {:?}", circ, tri);
    });
    */
    for IterItem { tri, circ } in Iter::new(100) {
        println!("   {:3} {:?}", circ, tri);
    }
}
