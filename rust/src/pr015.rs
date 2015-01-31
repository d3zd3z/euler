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

use std::iter;

define_problem!(pr015, 15, 137846528820);

static STEPS: uint = 20u;

fn pr015() -> u64 {
    let mut values: Vec<_> = iter::repeat(1u64).take(STEPS + 1).collect();

    for _ in 0u .. STEPS {
        bump(values.as_mut_slice());
    }

    values[STEPS]
}

fn bump(values: &mut [u64]) {
    for i in 0u .. STEPS {
        values[i+1] = values[i+1] + values[i];
    }
}
