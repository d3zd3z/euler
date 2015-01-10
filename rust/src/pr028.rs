// Problem 28
//
// 11 October 2002
//
//
// Starting with the number 1 and moving to the right in a clockwise
// direction a 5 by 5 spiral is formed as follows:
//
// 21 22 23 24 25
// 20  7  8  9 10
// 19  6  1  2 11
// 18  5  4  3 12
// 17 16 15 14 13
//
// It can be verified that the sum of the numbers on the diagonals is 101.
//
// What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral
// formed in the same way?
// 669171001

define_problem!(pr028, 28, 669171001);

fn pr028() -> uint {
    // Account for 1 in the center.
    let mut sum = 1;

    // ??? Range with step?
    let mut a = 3;
    while a <= 1001 {
        sum += ring_sum(a);
        a += 2;
    }
    sum
}

fn ring_sum(n: uint) -> uint {
    4*n*n - 6*n + 6
}
