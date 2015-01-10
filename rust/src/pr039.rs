// Problem 39
//
// 14 March 2003
//
//
// If p is the perimeter of a right angle triangle with integral length
// sides, {a,b,c}, there are exactly three solutions for p = 120.
//
// {20,48,52}, {24,45,51}, {30,40,50}
//
// For which value of p ≤ 1000, is the number of solutions maximised?
//
// 840

use triangle;
use std::collections::HashMap;
use std::collections::hash_map::Entry::{Occupied, Vacant};

define_problem!(pr039, 39, 840);

fn pr039() -> u32 {
    let mut map = HashMap::new();
    for triangle::IterItem { circ, .. } in triangle::Iter::new(1000) {
        match map.entry(circ) {
            Vacant(entry) => { entry.insert(1u32); },
            Occupied(mut entry) => *entry.get_mut() += 1,
        }
    }

    match map.iter().max_by(|p| p.1) {
        None => panic!("No solution found"),
        Some((&k, _)) => k
    }
}
