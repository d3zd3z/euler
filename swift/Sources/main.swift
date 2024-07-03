// The Swift Programming Language
// https://docs.swift.org/swift-book

protocol Problem {
    // The type of problem returns.
    associatedtype T: LosslessStringConvertible, Equatable

    // Actually run the problem.
    func run() -> T

    // The expected answer.
    var expected: T { get }

    // The problem number
    var number: Int { get }
}

enum ProblemError: Error {
    case incorrectResult(got: String, expected: String)
}

extension Problem {
    func check() throws {
        print("\(number): ", terminator:"")
        let result = run()
        print(result)
        if result != expected {
            throw ProblemError.incorrectResult(got: String(result), expected: String(expected))
        }
    }
}

enum EulerError: Error {
    case UnknownProblem(n: Int)
    case NotANumber(text: String)
}

// Build all of it (todo, generate this).
func genProblems() -> [Int: any Problem] {
    var result: [Int: any Problem] = [:]
    func add(_ prob: any Problem) {
        result[prob.number] = prob
    }
    add(Pr001())
    add(Pr002())
    add(Pr003())
    add(Pr004())
    add(Pr005())
    add(Pr006())
    add(Pr007())
    add(Pr008())
    add(Pr009())
    add(Pr010())
    add(Pr011())
    add(Pr012())
    add(Pr013())
    add(Pr014())
    add(Pr015())
    add(Pr016())
    return result
}

let problems = genProblems()

func runAll() throws {
    let probs = Array<Int>(problems.keys).sorted()
    for n in probs {
        try problems[n]!.check()
    }
}

let args = CommandLine.arguments
if args.count < 1 {
} else if args.count == 2 && args[1] == "all" {
    try runAll()
} else {
    for n in args[1..<args.count] {
        if let n2 = Int(n) {
            if let thunk = problems[n2] {
                try thunk.check()
            } else {
                throw EulerError.UnknownProblem(n: n2)
            }
        } else {
            throw EulerError.NotANumber(text: n)
        }
    }
}
