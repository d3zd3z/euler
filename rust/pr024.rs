// Problem 24
//
// 16 August 2002
//
//
// A permutation is an ordered arrangement of objects. For example, 3124 is
// one possible permutation of the digits 1, 2, 3 and 4. If all of the
// permutations are listed numerically or alphabetically, we call it
// lexicographic order. The lexicographic permutations of 0, 1 and 2 are:
//
// 012   021   102   120   201   210
//
// What is the millionth lexicographic permutation of the digits 0, 1, 2, 3,
// 4, 5, 6, 7, 8 and 9?
//
// 2783915460

// TODO: With rust 0.5, this produces the wrong result.

fn main() {
    let base: ~[mut u8] = vec::to_mut(do vec::from_fn(10) |i| {i as u8});
    let mut done = false;
    for (999_999u).times() || {
        next_permutation(base, &mut done);
        assert !done;
    }
    show(vec::from_mut(base));
}

fn show(digits: &[u8]) {
    let mut result = ~"";
    for digits.each() |x| { result += u8::str(*x); }
    io::println(result);
}

// Advance the items to the next permutation.  Sets 'done' to true if
// there are no more permutations.
fn next_permutation(items: &[mut u8], done: &mut bool) {
    let size = vec::len(items);
    let mut k = uint::max_value;
    for uint::range(0, size - 1) |x| {
        if items[x] < items[x+1] {
            k = x;
        }
    }
    if k == uint::max_value {
        *done = true;
        return
    }

    let mut l = uint::max_value;
    for uint::range(k + 1, size) |x| {
        if items[k] < items[x] {
            l = x;
        }
    }

    swap(items, k, l);
    flip(items, k + 1, size - 1);

    *done = false;
}

fn flip(items: &[mut u8], a: uint, b: uint) {
    let mut aa = a;
    let mut bb = b;
    while aa < bb {
        swap(items, aa, bb);
        aa += 1;
        bb -= 1;
    }
}

fn swap(items: &[mut u8], a: uint, b: uint) {
    let tmp = items[a];
    items[a] = items[b];
    items[b] = tmp;
}
