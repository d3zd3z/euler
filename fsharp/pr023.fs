// Problem 23
//
// 02 August 2002
//
//
// A perfect number is a number for which the sum of its proper divisors is
// exactly equal to the number. For example, the sum of the proper divisors
// of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect
// number.
//
// A number n is called deficient if the sum of its proper divisors is less
// than n and it is called abundant if this sum exceeds n.
//
// As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the
// smallest number that can be written as the sum of two abundant numbers is
// 24. By mathematical analysis, it can be shown that all integers greater
// than 28123 can be written as the sum of two abundant numbers. However,
// this upper limit cannot be reduced any further by analysis even though it
// is known that the greatest number that cannot be expressed as the sum of
// two abundant numbers is less than this limit.
//
// Find the sum of all the positive integers which cannot be written as the
// sum of two abundant numbers.
//
// 4179871

// Since we're computing all of the divisors, do it incrementally, rather
// than by division, which should be significantly faster.
let makeDivisors limit =
    let result = Array.create limit 1
    for i = 2 to limit-1 do
        let mutable n = i + i
        while n < limit do
            result.[n] <- result.[n] + i
            n <- n + i
    result

let makeAbundants limit =
    let divisors = makeDivisors limit
    let result = ref []
    Array.iteri (fun i dc -> if i > 0 && i < dc then result := i :: !result) divisors
    !result

let sums limit =
    let abundants = Array.ofList <| makeAbundants limit
    let s = Array.create limit false
    Array.iter (fun outer ->
        Array.iter (fun inner ->
            let t = outer + inner
            if t < limit then s.[t] <- true) abundants)
        abundants
    let mutable sum = 0
    for i = 1 to limit-1 do
        if not s.[i] then
            sum <- sum + i
    sum

let pr23 () = sums 28123

printfn "%A" (pr23 ())
