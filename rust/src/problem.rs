// Problem definition

#![macro_escape]

macro_rules! define_problem (($f:expr, $n:expr) => (
    pub struct Solution;

    impl super::Problem for Solution {
        fn run(&self) { $f(); }
        fn num(&self) -> uint { $n }
    }
))

macro_rules! add_problem( ($p:expr, $t:expr) => (
    $p.push(box $t as Box<super::Problem>)
))
