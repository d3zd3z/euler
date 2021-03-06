// Problem 6
//
// 14 December 2001
//
//
// The sum of the squares of the first ten natural numbers is,
//
// 1^2 + 2^2 + ... + 10^2 = 385
//
// The square of the sum of the first ten natural numbers is,
//
// (1 + 2 + ... + 10)^2 = 55^2 = 3025
//
// Hence the difference between the sum of the squares of the first ten
// natural numbers and the square of the sum is 3025 − 385 = 2640.
//
// Find the difference between the sum of the squares of the first one
// hundred natural numbers and the square of the sum.
//
// 25164150

let pr6 () =
  let nums = [ 1 .. 100 ]
  let sumsq = List.reduce (+) nums
  let sumsq = sumsq * sumsq
  let sq = List.map (fun x -> x * x) nums
  let sq = List.reduce (+) sq
  sumsq - sq

printfn "%A" (pr6 ())
