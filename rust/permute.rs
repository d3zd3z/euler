// TODO: Make this generic, but still useable.

// Advance the items to the next permutation.  Sets 'done' to true if
// there are no more permutations.
pub fn next_permutation(items: &[mut u8], done: &mut bool) {
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
