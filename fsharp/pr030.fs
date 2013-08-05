// Problem 30
//
// 08 November 2002
//
//
// Surprisingly there are only three numbers that can be written as the sum
// of fourth powers of their digits:
//
//     1634 = 1^4 + 6^4 + 3^4 + 4^4
//     8208 = 8^4 + 2^4 + 0^4 + 8^4
//     9474 = 9^4 + 4^4 + 7^4 + 4^4
//
// As 1 = 1^4 is not a sum it is not included.
//
// The sum of these numbers is 1634 + 8208 + 9474 = 19316.
//
// Find the sum of all the numbers that can be written as the sum of fifth
// powers of their digits.
//
// 443839

// Simple exponentation of integers.
let expt n pow =
    let rec loop result n pow =
        if pow = 0 then result else
            let result =
                if (pow &&& 1) <> 0 then
                    result * n
                else
                    result
            let n = n * n
            loop result n (pow >>> 1)
    loop 1 n pow

// Return the sum of the digits each raised to power.
let digitPowerSum number power =
    let rec loop number sum =
        if number = 0 then sum
        else
            let n = number / 10
            let m = number % 10
            loop n (sum + expt m power)
    loop number 0

// Calculate the largest number this power could possibly be.
let largestNumber power =
    let rec loop num =
        let sum = digitPowerSum num power
        if num > sum then sum
        else loop (num * 10 + 9)
    loop 9

let countSummable power =
    let mutable sum = 0
    for i = 2 to largestNumber power do
        if digitPowerSum i power = i then
            sum <- sum + i
    sum

let pr30 () = countSummable 5

printfn "%A" (pr30 ())
