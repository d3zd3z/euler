// Build all of it (todo, generate this).

enum EulerError: ErrorType {
    case UnknownProblem(n: Int)
    case NotANumber(text: String)
}

// The results can all be turned into strings.
func runIt<T>(thunk: (() -> T)) -> (() -> String) {
    return {
        () -> String in
        String(thunk())
    }
}

func genProblems() -> [Int: () -> String] {
    var result: [Int: () -> String] = [:]
    result[1] = runIt(pr001)
    result[2] = runIt(pr002)
    result[3] = runIt(pr003)
    result[4] = runIt(pr004)
    result[5] = runIt(pr005)
    result[6] = runIt(pr006)
    result[7] = runIt(pr007)
    result[8] = runIt(pr008)
    result[9] = runIt(pr009)
    result[10] = runIt(pr010)
    return result
}
let problems: [Int: () -> String] = genProblems()

func runAll() {
    let probs = Array<Int>(problems.keys).sort()
    for n in probs {
        let thunk = problems[n]!
        print("\(n): ", terminator:"")
        print(thunk())
    }
}

let args = Process.arguments
if args.count < 1 {
} else if args.count == 2 && args[1] == "all" {
    runAll()
} else {
    for n in args[1..<args.count] {
        if let n2 = Int(n) {
            if let thunk = problems[n2] {
                print("\(n2): ", terminator:"")
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
