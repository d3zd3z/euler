// Problem 1
//
// 05 October 2001
//
// If we list all the natural numbers below 10 that are multiples of 3 or 5,
// we get 3, 5, 6 and 9. The sum of these multiples is 23.
//
// Find the sum of all the multiples of 3 or 5 below 1000.
//
// // 234168

struct Pr001: Problem {
    typealias T = Int
    let number = 1
    let expected = 234168

    func run() -> Int {
        var total = 0
        for i in 1...1000 {
            if (i % 3 == 0) || (i % 5 == 0) {
                total += i
            }
        }
        return total
    }
}
