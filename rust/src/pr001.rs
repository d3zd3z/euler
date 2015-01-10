// Problem 1
// 
// 05 October 2001
// 
// If we list all the natural numbers below 10 that are multiples of 3 or 5,
// we get 3, 5, 6 and 9. The sum of these multiples is 23.
// 
// Find the sum of all the multiples of 3 or 5 below 1000.

define_problem!(pr001, 1, 233168);

fn pr001() -> u32 {
    let mut total = 0;
    for i in range(1u32, 1000) {
        if (i % 3 == 0) || (i % 5 == 0) {
            total += i;
        }
    }
    total
}
