// Project euler

// Testing is unstable, so bring it in when testing.
#![cfg_attr(test, feature(test))]

// extern crate collections;
extern crate num;
extern crate rand;

#[cfg(test)]
extern crate test;

use std::io;
use std::env;
use std::collections::HashMap;
use std::io::prelude::*;

mod problem;
mod plist;

mod sieve;
mod misc;
mod triangle;
mod permute;
mod miller;

// TODO: Maybe there is a way of doing function pointers.  But, this
// seems to be easier for now.
pub trait Problem {
    fn run(&self);
    fn num(&self) -> usize;
}

struct Problems {
    probs: HashMap<usize, Box<Problem + 'static>>
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

    fn run(&mut self, num: usize) {
        match self.probs.get(&num) {
            None => panic!("Unknown problem: {}", num),
            Some(p) => {
                print!("{:>3}: ", num);
                io::stdout().flush().unwrap();;
                p.run();
            }
        }
    }

    fn run_all(&mut self) {
        let mut keys: Vec<usize> = self.probs.keys().map(|&k| k).collect();
        keys.sort();
        for &n in keys.iter() {
            self.run(n);
        }
    }
}

#[allow(dead_code)]
fn main() {
    let mut probs = Problems::new();
    let args: Vec<String> = env::args().skip(1).collect();
    if args.len() == 0 {
        panic!("Usage: euler {{all | n1 n2 n3}}");
    } else if args.len() == 1 && args[0] == "all" {
        probs.run_all();
    } else {
        for p in args.iter() {
            probs.run(p.parse().unwrap());
        }
    }
    // TODO: Use the slice patterns when they stabilize.
    // match &args[..] {
    //     [ref all] if &all[..] == "all" => probs.run_all(),
    //     [] => panic!("Usage: euler {{all | n1 n2 n3}}"),
    //     pns => {
    //         for p in pns.iter() {
    //             probs.run(p.parse().unwrap())
    //         }
    //     }
    // }
}
