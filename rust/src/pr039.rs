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

use triangle::generate_triples;
use std::collections::hashmap::HashMap;
use std::collections::hashmap::{Occupied, Vacant};

define_problem!(main, 39)

fn main() {
    let mut map = HashMap::new();
    generate_triples(1000, |_, circ| {
        match map.entry(circ) {
            Vacant(entry) => { entry.set(1u); },
            Occupied(mut entry) => *entry.get_mut() += 1
        }
    });

    let k = match map.iter().max_by(|p| {p.val1()}) {
        None => panic!("No solution found"),
        Some((k, _)) => *k
    };

    println!("{}", k);
}