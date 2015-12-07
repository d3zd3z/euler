// Miscellaneous utilities.

// TODO: Figure out how to make this generic.

func is_palindrome(number: Int64, base: Int64) -> Bool {
    return number == reverse_number(number, base: base)
}

func reverse_number(number: Int64, base: Int64) -> Int64 {
    var n = number
    var result: Int64 = 0
    while n > 0 {
        result = result * base + n % base
        n /= base
    }
    return result
}

// print(is_palindrome(123454321, base: 10))
