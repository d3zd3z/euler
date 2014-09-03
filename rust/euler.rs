// Project euler

#![feature(macro_rules)]

extern crate collections;
extern crate num;

use std::os;
use std::collections::hashmap::HashMap;

mod problem;
mod plist;

mod sieve;
mod misc;
mod triangle;
mod permute;
mod miller;

// TODO: Maybe there is a way of doing function pointers.  But, this
// seems to be easier for now.
trait Problem {
    fn run(&self);
    fn num(&self) -> uint;
}

struct Problems {
    probs: HashMap<uint, Box<Problem + 'static>>
}

impl Problems {
    fn new() -> Problems {
        let probs = plist::make();

        // Verify that there are no duplicates.
        let mut all = HashMap::new();
        for p in probs.move_iter() {
            let num = p.num();
            if !all.insert(p.num(), p) {
                fail!("Duplicate problem {}, not running", num);
            }
        }

        Problems { probs: all }
    }

    fn run(&mut self, num: uint) {
        match self.probs.find(&num) {
            None => fail!("Unknown problem: {}", num),
            Some(p) => {
                print!("{}: ", num);
                std::io::stdio::flush();
                p.run();
            }
        }
    }

    fn run_all(&mut self) {
        let mut keys: Vec<uint> = self.probs.keys().map(|&k| k).collect();
        keys.sort();
        for &n in keys.iter() {
            self.run(n);
        }
    }
}

fn main() {
    let mut probs = Problems::new();
    match os::args().tail().as_slice() {
        [ref all] if all.as_slice() == "all" => probs.run_all(),
        [] => fail!("Usage: euler {{all | n1 n2 n3}}"),
        pns => {
            for p in pns.iter() {
                match std::from_str::FromStr::from_str(p.as_slice()) {
                    None => fail!("Invalid number: {}", p),
                    Some(n) => probs.run(n)
                };
            }
        }
    }
}
