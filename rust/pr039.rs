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
use std::hashmap::HashMap;
mod triangle;

fn main() {
    let mut map = HashMap::new();
    generate_triples(1000, |_, circ| {
        map.insert_or_update_with(circ, 1u, |_, x| {*x += 1});
    });

    let k = match map.iter().max_by(|p| {p.second()}) {
        None => fail!("No solution found"),
        Some((k, _)) => *k
    };

    println(format!("{}", k));
}
