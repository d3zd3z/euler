// Problem definition

#![macro_use]

macro_rules! define_problem {
    // The third argument gives an expected answer, which will be
    // checked in a test.  These also expect the test to return something that
    // is comparable to the result of the $f test function.
    ($f:expr, $n:expr, $sol:expr) => {
        pub struct Solution;

        impl super::Problem for Solution {
            fn run(&self) {
                let answer = $f();
                assert_eq!(answer, $sol);
                println!("{:<20} pass", answer);
            }
            fn num(&self) -> usize {
                $n
            }
        }

        // TODO: Once we can make constructed identifiers, come up with a
        // better name for this function.
        #[test]
        fn test() {
            let answer = $f();
            assert_eq!(answer, $sol);
        }
    };
}

macro_rules! add_problem( ($p:expr, $t:expr) => (
    $p.push(Box::new($t) as Box<dyn super::Problem>)
));
