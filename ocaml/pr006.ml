(**********************************************************************
 * Problem 6
 *
 * 14 December 2001
 *
 *
 * The sum of the squares of the first ten natural numbers is,
 *
 * 1^2 + 2^2 + ... + 10^2 = 385
 *
 * The square of the sum of the first ten natural numbers is,
 *
 * (1 + 2 + ... + 10)^2 = 55^2 = 3025
 *
 * Hence the difference between the sum of the squares of the first ten
 * natural numbers and the square of the sum is 3025 − 385 = 2640.
 *
 * Find the difference between the sum of the squares of the first one
 * hundred natural numbers and the square of the sum.
 **********************************************************************)

let solve' count =
  let nums = BatList.init count (function x -> x + 1) in
  let sumsq = List.fold_left (+) 0 nums in
  let sumsq = sumsq * sumsq in
  let sq = List.map (function x -> x * x) nums in
  let sq = List.fold_left (+) 0 sq in
  sumsq - sq

let solve () = solve' 100

let run () = Printf.printf "%d\n" (solve ())
