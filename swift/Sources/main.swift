// The Swift Programming Language
// https://docs.swift.org/swift-book

// Build all of it (todo, generate this).

enum EulerError: Error {
    case UnknownProblem(n: Int)
    case NotANumber(text: String)
}

// Treat the results as strings.
func runIt<T: LosslessStringConvertible>(thunk: @escaping (() -> T)) -> (() -> String) {
    return {
        () -> String in
        String(thunk())
    }
}

func genProblems() -> [Int: () -> String] {
    var result: [Int: () -> String] = [:]
    result[1] = runIt(thunk: pr001)
    result[2] = runIt(thunk: pr002)
    result[3] = runIt(thunk: pr003)
    result[4] = runIt(thunk: pr004)
    result[5] = runIt(thunk: pr005)
    result[6] = runIt(thunk: pr006)
    result[7] = runIt(thunk: pr007)
    result[8] = runIt(thunk: pr008)
    result[9] = runIt(thunk: pr009)
    result[10] = runIt(thunk: pr010)
    result[11] = runIt(thunk: pr011)
    result[12] = runIt(thunk: pr012)
    result[13] = runIt(thunk: pr013)
    result[14] = runIt(thunk: pr014)
    result[15] = runIt(thunk: pr015)
    result[16] = runIt(thunk: pr016)
    return result
}
let problems: [Int: () -> String] = genProblems()

func runAll() {
    let probs = Array<Int>(problems.keys).sorted()
    for n in probs {
        let thunk = problems[n]!
        print("\(n): ", terminator:"")
        print(thunk())
    }
}

let args = CommandLine.arguments
if args.count < 1 {
} else if args.count == 2 && args[1] == "all" {
    runAll()
} else {
    for n in args[1..<args.count] {
        if let n2 = Int(n) {
            if let thunk = problems[n2] {
                print("\(n2)", terminator:"")
                let result = thunk()
                print(result)
            } else {
                throw EulerError.UnknownProblem(n: n2)
            }
        } else {
            throw EulerError.NotANumber(text: n)
        }
    }
}
