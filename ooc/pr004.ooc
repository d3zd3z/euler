// Problem 4
//
// 16 November 2001
//
//
// A palindromic number reads the same both ways. The largest palindrome made
// from the product of two 2-digit numbers is 9009 = 91 × 99.
//
// Find the largest palindrome made from the product of two 3-digit numbers.
//
// 906609

main: func () {
    largest := 0
    for (a in 100 .. 999) {
        for (b in a .. 999) {
            c := a * b
            if (c > largest && isPalindrome(c))
                largest = c
        }
    }
    "#{largest}" println()
}

reverseDigits: func (num: Int) -> Int {
    result: Int = 0
    while (num > 0) {
        result = result * 10 + num % 10
        num /= 10
    }
    return result
}

isPalindrome: func (num: Int) -> Bool {
    return num == reverseDigits(num)
}
