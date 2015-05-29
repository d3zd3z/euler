// TODO: Make this generic, but still useable.

use std::usize;

// TODO: Figure out if there is some way of implementing this iterator.

/*
// The iterator is a little awkward.  It iterates and mutates the original
// data, but can't actually return it (without copying it).  So, the iterator
// just returns (), and the caller should refer to the original data (which has
// to be around anyway because of the borrow.
pub struct Iter<'a> {
    data: &'a mut [u8],
}

impl<'a> Iter<'a> {
    pub fn new<'b>(s: &'b mut [u8]) -> Iter<'b> {
        Iter { data: s }
    }
}

impl<'a> Iterator for Iter<'a> {
    type Item = &'a mut Iter<'a>;

    fn next(&mut self) -> Option<&'a mut Iter<'a>> {
        let mut done = true;
        next_permutation(self.data, &mut done);
        if done { None }
        else { Some(self) }
    }
}

#[test]
fn test_permute() {
    let mut work = vec!(1, 2, 3);
    for () in Iter::new(work.as_mut_slice()) {
        println!("p: {:?}", work);
    }
}
*/

/*
 * Another attempt that doesn't work.  This time, it can't come up with
 * something to return.  This one is probably actually safe, but probably needs
 * a safety indicator from the borrow checker.
// Container to hold the mutator itself.
pub struct Permuter(Vec<u8>);

impl Permuter {
    pub fn iter<'a>(&'a mut self) -> Iter<'a> {
        Iter { data: &self.0[] }
    }
}

pub struct Iter<'a> {
    data: &'a mut [u8],
}

impl<'a> Iterator for Iter<'a> {
    type Item = &'a [u8];

    fn next(&mut self) -> Option<&'a [u8]> {
        let mut done;
        next_permutation(self.data, &mut done);
        if done {
            None
        } else {
            Some(self.data)
        }
    }
}
*/

/*
 * First attempt.  Can't pass borrow checker.
 * There isn't any way to make this safe with the data actually stored in the
 * iterator itself.
pub struct Iter {
    data: Vec<u8>
}

impl Iter {
    pub fn new_vec(data: Vec<u8>) -> Iter {
        Iter { data: data }
    }
}

impl<'a> Iterator for Iter {
    type Item = &'a [u8];

    fn next(&mut self) -> Option<&'a [u8]> {
        let mut done;
        next_permutation(&self.data[], &mut done);
        if done {
            None
        } else {
            Some(&self.data[])
        }
    }
}
*/

/// Advance the items to the next permutation.  Sets 'done' to true if
/// there are no more permutations.
pub fn next_permutation(items: &mut [u8], done: &mut bool) {
    let size = items.len();
    let mut k = usize::MAX;
    for x in 0 .. size - 1 {
        if items[x] < items[x+1] {
            k = x;
        }
    }
    if k == usize::MAX {
        *done = true;
        return
    }

    let mut l = usize::MAX;
    for x in k + 1 .. size {
        if items[k] < items[x] {
            l = x;
        }
    }

    swap(items, k, l);
    flip(items, k + 1, size - 1);

    *done = false;
}

fn flip(items: &mut [u8], a: usize, b: usize) {
    let mut aa = a;
    let mut bb = b;
    while aa < bb {
        swap(items, aa, bb);
        aa += 1;
        bb -= 1;
    }
}

fn swap(items: &mut [u8], a: usize, b: usize) {
    let tmp = items[a];
    items[a] = items[b];
    items[b] = tmp;
}

/// A basic benchmark of the permutations
/// libstd contains a `permutations` method, but the iterator clones.  Since
/// the iteration requires a mutable vector, there doesn't seem any safe way of
/// doing this with the normal iterator protocol.  As of recent tests, just
/// using next_permutation instead of the iterator is about 6.5 times faster.
///
/// Also, some of the euler problems require the permutation to be done
/// strictly in lexicographical order, which the `permutation()` method does
/// not do.
#[cfg(not_test)]
mod bench {
    use super::*;
    const BENCH_SIZE: u8 = 6;

    #[bench]
    fn bench_myperm(b: &mut ::test::Bencher) {
        b.iter(|| {
            let mut nums: Vec<u8> = (0 .. BENCH_SIZE).collect();
            let mut done = false;

            loop {
                next_permutation(&mut nums[..], &mut done);
                if done { break; }
            }
        });
    }

    // Also benchmark the cloning iterator part of normal slices.
    #[bench]
    fn bench_stdperm(b: &mut ::test::Bencher) {
        b.iter(|| {
            let nums: Vec<u8> = (0 .. BENCH_SIZE).collect();
            for _pv in nums.permutations() {
            }
        });
    }
}
