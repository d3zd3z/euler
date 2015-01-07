// A simple prime number sieve.

// extern mod extra;
use collections::bitv::Bitv;
// use extra::bitv::*;
// use extra::sort;

static DEFAULT_SIZE: uint = 8192u;

pub struct Sieve {
    vec: Bitv, limit: uint
}

impl Sieve {
    pub fn new() -> Sieve {
        let mut result = Sieve { vec: Bitv::from_elem(DEFAULT_SIZE + 1, true),
            limit: DEFAULT_SIZE };
        result.fill();
        result
    }
}

impl Sieve {
    fn fill(&mut self) {
        self.vec.set_all();
        self.vec.set(0, false);
        self.vec.set(1, false);

        let mut pos = 2u;
        let limit = self.limit;
        while pos <= limit {
            if !self.vec[pos] {
                pos += 2;
            } else {
                let mut n = pos + pos;
                while n <= limit {
                    self.vec.set(n, false);
                    n += pos;
                }
                if pos == 2 {
                    pos += 1;
                } else {
                    pos += 2;
                }
            }
        }
    }
}

impl Sieve {
    pub fn is_prime(&mut self, n: uint) -> bool {
        if n >= self.limit {
            let mut new_limit = self.limit;
            while new_limit < n {
                new_limit *= 8;
            }

            self.vec = Bitv::from_elem(new_limit + 1, true);
            self.limit = new_limit;
            self.fill();
        }

        self.vec[n]
    }
}

#[test]
fn test_basic() {
    let mut sieve = Sieve::new();
    assert!(sieve.is_prime(2));
    assert!(sieve.is_prime(3));
    assert!(sieve.is_prime(5));
    assert!(sieve.is_prime(65537));
}

impl Sieve {
    #[allow(dead_code)]
    pub fn next_prime(&mut self, n: uint) -> uint {
        if n == 2 {
            return 3;
        }

        let mut next = n + 2;
        while ! self.is_prime(next) {
            next += 2;
        }
        next
    }

    #[allow(dead_code)]
    pub fn prev_prime(&mut self, n: uint) -> uint {
        if n == 3 {
            return 2;
        }
        if n == 2 {
            panic!("No prime before 2");
        }

        let mut next = n - 2;
        while !self.is_prime(next) {
            next -= 2;
        }
        next
    }
}

#[test]
fn test_next() {
    let mut sieve = Sieve::new();
    assert!(sieve.next_prime(2) == 3);
}

impl Sieve {
    #[allow(dead_code)]
    pub fn factorize(&mut self, n: uint) -> Vec<Factor> {
        let mut result = vec![];
        let mut tmp = n;
        let mut prime = 2;
        let mut count = 0;

        while tmp > 1 {
            if tmp % prime == 0 {
                tmp /= prime;
                count += 1;
            } else {
                if count > 0 {
                    result.push(Factor{prime: prime, power: count});
                    count = 0;
                }

                if tmp > 1 {
                    prime = self.next_prime(prime);
                }
            }
        }

        if count > 0 {
            result.push(Factor {prime: prime, power: count});
        }

        result
    }

    #[allow(dead_code)]
    pub fn divisors(&mut self, n: uint) -> Vec<uint> {
        let factors = self.factorize(n);
        let mut result = vec![];
        spread(factors.as_slice(), &mut result);
        // do sort::merge_sort(result) |a, b| { *a <= *b }
        result.sort();
        result
    }
}

#[test]
fn test_factorize() {
    let mut sieve = Sieve::new();
    let f = sieve.divisors(138*2);
    println!("{}\n", f);
}

#[derive(PartialEq, Eq, Hash, Clone)]
pub struct Factor {
    pub prime: uint,
    pub power: uint
}

#[allow(dead_code)]
fn spread(factors: &[Factor], result: &mut Vec<uint>) {
    let len = factors.len();
    if len == 0 {
        result.push(1);
    } else {
        let mut rest = vec![];
        let x = factors[0].clone();
        spread(factors.slice(1, len), &mut rest);

        let mut power = 1;
        for i in range(0u, x.power + 1) {
            for elt in rest.iter() {
                result.push(*elt * power);
            }
            if i < power {
                power *= x.prime;
            }
        }
    }
}
