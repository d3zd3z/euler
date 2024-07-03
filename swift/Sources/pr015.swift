// Problem 15
//
// 19 April 2002
//
//
// Starting in the top left corner of a 2x2 grid, there are 6 routes (without
// backtracking) to the bottom right corner.
//
// [p_015]
//
// How many routes are there through a 20x20 grid?
//
// 137846528820

struct Pr015: Problem {
    typealias T = Int
    let number = 15
    let expected = 137846528820

    func run() -> Int {
        let STEPS = 20
        var values = Array(repeating: 1, count: STEPS + 1)

        for _ in 0 ..< STEPS {
            Self.bump(&values)
        }

        return values[STEPS]
    }

    static func bump(_ values: inout [Int]) {
        for i in 0 ..< values.count-1 {
            values[i+1] += values[i]
        }
    }
}
