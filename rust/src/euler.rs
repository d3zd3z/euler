// Project euler

// Features still considered unstable that need to be explicitly enabled.
#![feature(int_uint)]
#![feature(collections)]
#![feature(old_path)]
#![feature(old_io)]
#![feature(os)]
#![feature(rand)]
#![feature(std_misc)]

// This really shouldn't be enabled, but fmt/io are not reconciled, so
// #[derive(Debug)] needs this.
// Also, the 'Int' trait requires this.
#![feature(core)]

// Testing is unstable, so bring it in when testing.
#![cfg_attr(test, feature(test))]

extern crate collections;
extern crate num;

#[cfg(test)]
extern crate test;

use std::old_io as io;
use std::os;
use std::collections::HashMap;

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
        for p in probs.into_iter() {
            let num = p.num();
            if !all.insert(p.num(), p).is_none() {
                panic!("Duplicate problem {}, not running", num);
            }
        }

        Problems { probs: all }
    }

    fn run(&mut self, num: uint) {
        match self.probs.get(&num) {
            None => panic!("Unknown problem: {}", num),
            Some(p) => {
                print!("{:>3}: ", num);
                io::stdio::flush();
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

#[allow(dead_code)]
fn main() {
    let mut probs = Problems::new();
    match &os::args().tail()[..] {
        [ref all] if &all[..] == "all" => probs.run_all(),
        [] => panic!("Usage: euler {{all | n1 n2 n3}}"),
        pns => {
            for p in pns.iter() {
                probs.run(p.parse().unwrap())
            }
        }
    }
}
