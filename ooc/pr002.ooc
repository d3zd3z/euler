// Problem 2
//
// 19 October 2001
//
//
// Each new term in the Fibonacci sequence is generated by adding the
// previous two terms. By starting with 1 and 2, the first 10 terms will be:
//
// 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
//
// By considering the terms in the Fibonacci sequence whose values do not
// exceed four million, find the sum of the even-valued terms.
//
// 4613732

main: func () {
    total := 0
    a := 1
    b := 2
    while (b < 4_000_000) {
        if ((b & 1) == 0)
            total += b
        // Looks like it should work, but doesn't
        // TODO: Report this.
        // (a, b) = (b, a + b)
        tmp := a + b
        a = b
        b = tmp
    }
    "#{total}" println()
}