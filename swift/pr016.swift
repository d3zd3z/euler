// Problem 16
//
// 03 May 2002
//
//
// 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
//
// What is the sum of the digits of the number 2^1000?
//
//
// 1366

struct BigNum {
    var digits: [Int8]

    init(_ size: Int) {
        digits = [Int8](count: size, repeatedValue: 0)
        digits[0] = 1
    }

    mutating func double() {
        var carry: Int8 = 0
        for i in 0 ..< digits.count {
            let temp = digits[i] * 2 + carry
            digits[i] = temp % 10
            carry = temp / 10
        }

        if carry != 0 {
            fatalError("Numeric Overflow")
        }
    }
}

func pr016() -> Int {
    var digits = BigNum(302)
    for _ in 0 ..< 1000 {
        digits.double()
    }
    return digits.digits.reduce(0, combine: {$0 + Int($1)})
}
