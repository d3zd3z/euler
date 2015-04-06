// Generate the problem list based on available modules.

use std::env;
use std::fs;
use std::io::prelude::*;
use std::fs::File;
use std::path::Path;

use regex::Regex;

extern crate regex;

fn main() {
    let odir = env::var("OUT_DIR").unwrap();
    let dst = Path::new(&odir);
    let gen_name = dst.join("plist.rs");
    let mut f = File::create(&gen_name).unwrap();
    writeln!(&mut f, "// Auto-generated, do not edit.").unwrap();
    writeln!(&mut f, "").unwrap();
    writeln!(&mut f, "pub use super::Problem;").unwrap();
    writeln!(&mut f, "").unwrap();

    let problems = get_problems();

    // Generate the inputs.
    for &p in problems.iter() {
        writeln!(&mut f, "#[path=\"pr{0:03}.rs\"] mod pr{0:03};", p).unwrap();
    }
    writeln!(&mut f, "").unwrap();

    // Make the problem set.
    writeln!(&mut f, "pub fn make() -> Vec<Box<Problem + 'static>> {{").unwrap();
    writeln!(&mut f, "    let mut probs = Vec::new();").unwrap();
    for &p in problems.iter() {
        writeln!(&mut f, "    add_problem!(probs, pr{:03}::Solution);", p).unwrap();
    }
    writeln!(&mut f, "    probs").unwrap();
    writeln!(&mut f, "}}").unwrap();

    drop(f);

    // Unfortunately, this file can't be include!() into the outer source (macros can't expand to
    // 'mod' or 'use' declarations).  To work around this, make a symlink to the generated file.
    // We'll ignore it, and always replace it for each checkout.  It's a little better than just
    // dropping the generated file into the tree (but not much better).
    let src_name = Path::new("src/plist.rs");
    fs::remove_file(&src_name).unwrap();
    fs::soft_link(&gen_name, &src_name).unwrap();
}

// Get all of the problems, based on standard filenames of "src/prxxx.rs" where xxx is the problem
// number.  Returns the result, sorted.
fn get_problems() -> Vec<u32> {
    let mut result = vec![];

    let re = Regex::new(r"^.*/pr(\d\d\d)\.rs$").unwrap();
    for entry in fs::read_dir(&Path::new("src")).unwrap() {
        let entry = entry.unwrap();
        let p = entry.path();
        let n = p.as_os_str().to_str();
        let name = match n {
            Some(n) => n,
            None => continue,
        };
        match re.captures(name) {
            None => continue,
            Some(cap) => {
                let num: u32 = cap.at(1).unwrap().parse().unwrap();
                result.push(num);
            },
        }
    }

    result.sort();
    result
}
