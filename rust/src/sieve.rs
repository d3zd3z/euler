// A simple prime number sieve.

use std::iter;

static DEFAULT_SIZE: usize = 8192usize;

pub struct Sieve {
    vec: Vec<bool>,
    limit: usize
}

impl Sieve {
    pub fn new() -> Sieve {
        let mut result = Sieve {
            vec: iter::repeat(true).take(DEFAULT_SIZE + 1).collect(),
            limit: DEFAULT_SIZE,
        };
        result.fill();
        result
    }
}

impl Sieve {
    fn fill(&mut self) {
        // self.vec.set_all();
        self.vec[0] = false;
        self.vec[1] = false;

        let mut pos = 2;
        let limit = self.limit;
        while pos <= limit {
            if !self.vec[pos] {
                pos += 2;
            } else {
                let mut n = pos + pos;
                while n <= limit {
                    self.vec[n] = false;
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
    pub fn is_prime(&mut self, n: usize) -> bool {
        if n >= self.limit {
            let mut new_limit = self.limit;
            while new_limit < n {
                new_limit *= 8;
            }

            self.vec = iter::repeat(true).take(new_limit + 1).collect();
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

/*
#[bench]
fn bench_sieve(b: &mut ::test::Bencher) {
    b.iter(|| {
        let mut sieve = Sieve::new();
        assert_eq!(sieve.next_prime(100001), 100003);
    });
}
*/

impl Sieve {
    #[allow(dead_code)]
    pub fn next_prime(&mut self, n: usize) -> usize {
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
    pub fn prev_prime(&mut self, n: usize) -> usize {
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

    pub fn primes_upto(&mut self, n: usize) -> PrimeIter {
        PrimeIter {
            sieve: self,
            cur: 2,
            stop: n,
        }
    }
}

pub struct PrimeIter<'a> {
    sieve: &'a mut Sieve,
    cur: usize,
    stop: usize,
}

impl<'a> Iterator for PrimeIter<'a> {
    type Item = usize;

    fn next(&mut self) -> Option<usize> {
        let result = self.cur;
        if result >= self.stop {
            return None;
        }
        self.cur = self.sieve.next_prime(result);
        Some(result)
    }
}

#[test]
fn test_next() {
    let mut sieve = Sieve::new();
    assert!(sieve.next_prime(2) == 3);
}

impl Sieve {
    #[allow(dead_code)]
    pub fn factorize(&mut self, n: usize) -> Vec<Factor> {
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
                    result.push(Factor {
                        prime,
                        power: count,
                    });
                    count = 0;
                }

                if tmp > 1 {
                    prime = self.next_prime(prime);
                }
            }
        }

        if count > 0 {
            result.push(Factor {
                prime,
                power: count,
            });
        }

        result
    }

    #[allow(dead_code)]
    pub fn divisors(&mut self, n: usize) -> Vec<usize> {
        let factors = self.factorize(n);
        let mut result = vec![];
        spread(&factors[..], &mut result);
        // do sort::merge_sort(result) |a, b| { *a <= *b }
        result.sort_unstable();
        result
    }
}

#[test]
fn test_factorize() {
    let mut sieve = Sieve::new();
    let f = sieve.divisors(138*2);
    println!("{:?}\n", f);
}

#[derive(Debug, PartialEq, Eq, Hash, Clone)]
pub struct Factor {
    pub prime: usize,
    pub power: usize
}

#[allow(dead_code)]
fn spread(factors: &[Factor], result: &mut Vec<usize>) {
    let len = factors.len();
    if len == 0 {
        result.push(1);
    } else {
        let mut rest = vec![];
        let x = factors[0].clone();
        spread(&factors[1 .. len], &mut rest);

        let mut power = 1;
        for i in 0 .. x.power + 1 {
            for elt in rest.iter() {
                result.push(*elt * power);
            }
            if i < power {
                power *= x.prime;
            }
        }
    }
}
