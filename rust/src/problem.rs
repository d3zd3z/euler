// Problem definition

#![macro_use]

macro_rules! define_problem {
    ($f:expr, $n:expr) => (
        pub struct Solution;

        impl super::Problem for Solution {
            fn run(&self) { $f(); }
            fn num(&self) -> uint { $n }
        });

    // A possible third argument gives an expected answer, which will be
    // checked in a test.  These also expect the test to return something that
    // is comparable to the result of the $f test function.
    ($f:expr, $n:expr, $sol:expr) => (
        pub struct Solution;

        impl super::Problem for Solution {
            fn run(&self) {
                let answer = $f();
                assert_eq!(answer, $sol);
                println!("{:<20} pass", answer);
            }
            fn num(&self) -> uint { $n }
        }

        // TODO: Once we can make constructed identifiers, come up with a
        // better name for this function.
        #[test]
        fn test() {
            let answer = $f();
            assert_eq!(answer, $sol);
        });
}

macro_rules! add_problem( ($p:expr, $t:expr) => (
    $p.push(box $t as Box<super::Problem>)
));
