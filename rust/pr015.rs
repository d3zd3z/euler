// Problem 15
//
// 19 April 2002
//
//
// Starting in the top left corner of a 2x2 grid, there are 6 routes (without
// backtracking) to the bottom right corner.
//
// [p_015]
//
// How many routes are there through a 20x20 grid?
//
// 137846528820

const steps: uint = 20u;

fn main() {
    let values: ~[mut u64] = vec::to_mut(vec::from_elem(steps + 1u, 1u64));

    for uint::range(0u, steps) |_x| {
        bump(values);
    }
    io::println(fmt!("%?", values[steps]));
}

fn bump(values: &[mut u64]) {
    for uint::range(0u, steps) |i| {
        values[i+1u] = values[i+1u] + values[i];
    }
}
