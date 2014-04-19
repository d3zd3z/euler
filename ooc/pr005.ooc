// Problem 5
//
// 30 November 2001
//
//
// 2520 is the smallest number that can be divided by each of the numbers
// from 1 to 10 without any remainder.
//
// What is the smallest positive number that is evenly divisible by all of
// the numbers from 1 to 20?
//
// 232792560

main: func () {
    total := 1
    for (i in 2 .. 20)
        total = lcm(total, i)
    "#{total}" println()
}

lcm: func (a: Int, b: Int) -> Int {
    return (a / gcd(a, b)) * b
}

gcd: func (a: Int, b: Int) -> Int {
    while (b != 0) {
        tmp := a % b
        a = b
        b = tmp
    }
    return a
}
