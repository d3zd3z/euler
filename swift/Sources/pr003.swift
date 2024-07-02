// Problem 3
//
// 02 November 2001
//
// The prime factors of 13195 are 5, 7, 13 and 29.
//
// What is the largest prime factor of the number 600851475143 ?
//
// 6857

// First solution, without the prime sieve.

func pr003() -> Int64 {
    var num: Int64 = 600851475143
    var p: Int64 = 3
    while true {
        while num % p == 0 {
            num /= p
        }

        if num == 1 {
            break
        }

        p += 2
    }
    return p
}
