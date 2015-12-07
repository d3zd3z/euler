// Problem 5
// 
// 30 November 2001
// 
// 2520 is the smallest number that can be divided by each of the numbers
// from 1 to 10 without any remainder.
// 
// What is the smallest positive number that is evenly divisible by all of
// the numbers from 1 to 20?
//
// 232792560

func pr005() -> Int64 {
    var n: Int64 = 1
    for j in Int64(2) ... 20 {
        n = lcm(n, j)
    }
    return n
}

func lcm(a: Int64, _ b: Int64) -> Int64 {
    return (a / gcd(a, b)) * b
}

func gcd(a: Int64, _ b: Int64) -> Int64 {
    var aa = a
    var bb = b
    while true {
        if bb == 0 {
            return aa
        }
        let tmp = aa%bb
        aa = bb
        bb = tmp
    }
}
