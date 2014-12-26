// Generate the problem list based on available modules.

#![feature(phase)]

#[phase(plugin)]
extern crate regex_macros;
extern crate regex;

use std::os;
use std::io::fs;
use std::io::File;
use std::str::from_utf8;

fn main() {
    let dst = Path::new(os::getenv("OUT_DIR").unwrap());
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
    let _ = fs::unlink(&src_name);
    fs::symlink(&gen_name, &src_name).unwrap();
}

// Get all of the problems, based on standard filenames of "src/prxxx.rs" where xxx is the problem
// number.  Returns the result, sorted.
fn get_problems() -> Vec<uint> {
    let mut result = vec![];

    let re = regex!(r"^pr(\d{3})\.rs$");

    for path in fs::readdir(&Path::new("src")).unwrap().iter() {
        let rawname = path.filename().unwrap();
        let name = from_utf8(rawname).unwrap();
        match re.captures(name) {
            None => (),
            Some(caps) => {
                result.push(caps.at(1).unwrap().parse().unwrap());
            }
        }
    }

    result.sort();
    result
}
