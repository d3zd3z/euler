// TODO: Make this generic, but still useable.

use std::uint;

// Advance the items to the next permutation.  Sets 'done' to true if
// there are no more permutations.
pub fn next_permutation(items: &mut [u8], done: &mut bool) {
    let size = items.len();
    let mut k = uint::MAX;
    for x in range(0, size - 1) {
        if items[x] < items[x+1] {
            k = x;
        }
    }
    if k == uint::MAX {
        *done = true;
        return
    }

    let mut l = uint::MAX;
    for x in range(k + 1, size) {
        if items[k] < items[x] {
            l = x;
        }
    }

    swap(items, k, l);
    flip(items, k + 1, size - 1);

    *done = false;
}

fn flip(items: &mut [u8], a: uint, b: uint) {
    let mut aa = a;
    let mut bb = b;
    while aa < bb {
        swap(items, aa, bb);
        aa += 1;
        bb -= 1;
    }
}

fn swap(items: &mut [u8], a: uint, b: uint) {
    let tmp = items[a];
    items[a] = items[b];
    items[b] = tmp;
}
