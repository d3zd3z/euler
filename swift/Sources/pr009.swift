// Problem 9
//
// 25 January 2002
//
// A Pythagorean triplet is a set of three natural numbers, a < b < c, for
// which,
//
// a^2 + b^2 = c^2
//
// For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
//
// There exists exactly one Pythagorean triplet for which a + b + c = 1000.
// Find the product abc.
//
// 31875000

struct Pr009: Problem {
    typealias T = Int
    let number = 9
    let expected = 31875000

    func run() -> Int {
        for a in 1 ..< 1000 {
            for b in a ..< 1000 {
                let c = 1000 - a - b
                if c > b && a*a + b*b == c*c {
                    return a * b * c
                }
            }
        }
        fatalError("Unreachable")
    }
}
