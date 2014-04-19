// Problem 3
//
// 02 November 2001
//
//
// The prime factors of 13195 are 5, 7, 13 and 29.
//
// What is the largest prime factor of the number 600851475143 ?
//
// 6857

main: func () {
    num: Int64 = 600851475143
    p := 3
    while (num > 1) {
        if (num % p == 0)
            num /= p
        else
            p += 2
    }
    "#{p}" println()
}
