// Problem 4
//
// 16 November 2001
//
// A palindromic number reads the same both ways. The largest palindrome made
// from the product of two 2-digit numbers is 9009 = 91 × 99.
//
// Find the largest palindrome made from the product of two 3-digit numbers.
//
// 906609

func pr004() -> Int64 {
    var max: Int64 = 0
    for a in Int64(100) ..< 1000 {
        for b in a ..< 1000 {
            let c = a * b
            if c > max && is_palindrome(c, base: 10) {
                max = c
            }
        }
    }

    return max
}
