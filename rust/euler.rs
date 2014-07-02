// Project euler

#![feature(macro_rules)]

extern crate collections;
extern crate num;

use std::os;

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
    probs: Vec<Box<Problem>>
}

impl Problems {
    fn new() -> Problems {
        Problems { probs: plist::make() }
    }

    fn run(&mut self, num: uint) {
        let mut prob = None;
        for p in self.probs.iter() {
            if p.num() == num {
                prob = Some(p);
                break
            }
        }
        match prob {
            None => fail!("Unknown problem: {}", num),
            Some(p) => {
                print!("{}: ", num);
                std::io::stdio::flush();
                p.run();
            }
        };
    }

    fn run_all(&mut self) {
        for p in self.probs.iter() {
            print!("{}: ", p.num());
            std::io::stdio::flush();
            p.run();
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
